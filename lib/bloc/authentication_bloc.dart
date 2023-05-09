import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/login.dart';
import '../network/response.dart';
import '../network/rest_client.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  AuthenticationBloc():super(AuthenticationState(username: '', password: '', showPassword: false, rememberPassword: false, loading: false)){
    on<AuthenticationEvent>((event,emit){
      if(event is ShowPassword){
        print(event.onChanged);
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
      try{
        emit(state.copyWith(loading: true));
        SignInResponse response = await RestClient.client.signIn(SignInRequest(state.username,state.password));
        emit(state.copyWith(response: response,loading:false));
      }
      catch(error,stacktrace){
        if(error is DioError){
          if(error.response is BaseResponse){
            emit(state.copyWith(success: false,errorResponse: error.response as BaseResponse,loading:false));
          }
        }
        else {
          emit(state.copyWith(success: false,loading:false));
        }
        debugPrintStack(stackTrace:stacktrace);
      }
    });
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
    required this.loading, String? message, bool? success,this.errorResponse
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



  @override
  // TODO: implement props
  List<Object?> get props => [showPassword,loading,rememberPassword,username,password,response,success,message,errorResponse];

  AuthenticationState copyWith({
    String? username,
    String? password,
    bool? showPassword,
    bool? rememberPassword,
    bool? loading,
    SignInResponse? response,
    String? message,
    bool? success,
    BaseResponse? errorResponse,
  }) {
    return AuthenticationState(
      username: username ?? this.username,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      rememberPassword: rememberPassword ?? this.rememberPassword,
      loading: loading ?? this.loading,
      response: response ?? this.response,
      message: message ?? this.message,
      success: success ?? this.success,
      errorResponse: errorResponse ?? this.errorResponse
    );
  }
}