import 'package:authentication/network/get_me.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/login.dart';
import '../network/response.dart';
import '../network/rest_client.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  AuthenticationBloc():super(AuthenticationState(username: '', password: '', showPassword: false, rememberPassword: false, loading: false,success: false)){
    on<AuthenticationEvent>((event,emit){
      if(event is ShowPassword){
        emit(state.copyWith(showPassword: event.onChanged));
      }
      if(event is UsernameChanged){
          emit(state.copyWith(username: event.text));
      }
      if(event is PasswordChanged) {
        emit(state.copyWith(password: event.text));
      }
      if(event is RememberPassword){
        emit(state.copyWith(rememberPassword:event.onChanged));
      }
    });
    on<LoginButtonPressed>((event,emit) async{
      late SignInResponse response;
      String message = "Undefined Error";
      bool success = false;
      try{
        emit(state.copyWith(loading: true));
        response = await GetIt.instance<RestClient>().signIn(SignInRequest(state.username,state.password));
        success = true;
      }
      catch(error,stacktrace){
        if(error is DioError) {
          debugPrintStack(stackTrace:stacktrace);
            switch (error.type) {
              case DioErrorType.cancel:
                message = "Request to API server was cancelled";
                break;
              case DioErrorType.connectionTimeout:
                message = "Connection timeout with API server";
                break;
              case DioErrorType.receiveTimeout:
                message = "Receive timeout in connection with API server";
                break;
              case DioErrorType.sendTimeout:
                message = "Send timeout in connection with API server";
                break;
              case DioErrorType.badResponse:
                var badResponse = BaseResponse.BaseResponseFromJsonWithErrorHandling(error.response?.data);
                message = badResponse!=null? badResponse.message! :"Bad Request";
                break;
              case DioErrorType.connectionError:
                message = "Unexpected error occurred. Cannot connected to server";
                break;
              case DioErrorType.unknown:
                if (error.message!=null&& error.message!.contains("SocketException")) {
                  message = 'No Internet';
                  break;
                }
                message = "Unexpected error occurred";
                break;
              default:
                message = "Something went wrong";
                break;
            }
        }
      }
      if(success){
        //emit(state.copyWith(response: response,loading:false,success: true));
        _saveInformation(response);
        _getMe(response);
      }
      else{
          emit(state.copyWith(success: false,message: message,loading:false));
      }
    });
  }

  void _saveInformation(SignInResponse response) async{
    SharedPreferences preferences = await GetIt.instance<SharedPreferences>();
    preferences.setString(SharedPreferencesKey.TOKEN_HADU, response.system!.token!);
    preferences.setString(SharedPreferencesKey.ROLE, response.system!.role!);
    preferences.setString(SharedPreferencesKey.TOKEN_ROCKET,response.rocket!.data!.authToken!);
    preferences.setString(SharedPreferencesKey.USER_ID_ROCKET, response.rocket!.data!.userId!);
  }


  void _getMe(SignInResponse response) async{
    GetMeResponse response = await GetIt.instance<RestClient>().getMe();
    String message;
    try{
      emit(state.copyWith(success: true,loading: false));
    }
    catch(error,stacktrace){
      debugPrintStack(stackTrace: stacktrace);
      if(error is DioError){

      }
      else{
        message = "Undefined Error";
      }
    }
  }
}


class AuthenticationEvent{}

class LoginButtonPressed extends AuthenticationEvent{
}

class UsernameChanged extends AuthenticationEvent{
  String text;
  UsernameChanged(this.text);
}
class PasswordChanged extends AuthenticationEvent{
  String text;
  PasswordChanged(this.text);
}

class TextChanged extends AuthenticationEvent{
  String? username;
  String? password;
  TextChanged({String? username,String? password});
}

class ShowPassword extends AuthenticationEvent{
  ShowPassword(this.onChanged);
  bool onChanged;
}
class RememberPassword extends AuthenticationEvent{
  RememberPassword(this.onChanged);
  bool onChanged;
}

class AuthenticationState extends Equatable{
  AuthenticationState({
    required this.username,
    required this.password,
    this.response,
    required this.showPassword,
    required this.rememberPassword,
    required this.loading, this.message, this.success,this.errorResponse
  });

  String username;
  String password;
  bool showPassword;
  bool rememberPassword;
  bool loading;
  SignInResponse? response;
  BaseResponse? errorResponse;
  String? message;
  bool? success;

  bool get canLogin => username.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props => [showPassword,loading,rememberPassword,username,password,response,success,message,errorResponse];

  AuthenticationState copyWith({
    String? username,
    String? password,
    bool? showPassword,
    bool? rememberPassword,
    bool? loading,
    SignInResponse? response,
    BaseResponse? errorResponse,
    String? message,
    bool? success,
  }) {
    return AuthenticationState(
      username: username ?? this.username,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      rememberPassword: rememberPassword ?? this.rememberPassword,
      loading: loading ?? this.loading,
      response: response ?? this.response,
      errorResponse: errorResponse ?? this.errorResponse,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }
}