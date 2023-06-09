import 'package:authentication/bloc/authentication/authentication_bloc.dart';
import 'package:authentication/bloc/authentication/authentication_event.dart';
import 'package:authentication/bloc/authentication/authentication_state.dart';
import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/network/network_bloc.dart';
import 'package:authentication/network/local/local_data_utils.dart';
import 'package:authentication/network/response/get_me.dart';
import 'package:authentication/network/response/login_response.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/request/login.dart';
import '../../network/response/response.dart';
import '../../network/network/rest_client.dart';

class AuthenticationBloc extends NetworkBloc<AuthenticationEvent,AuthenticationState>{
  AuthenticationBloc():super(AuthenticationState(username: '', password: '', showPassword: false, rememberPassword: false, loading: false,success: false, message: '')){
    on<AuthenticationEvent>((event,emit){
      if(event is ShowPassword){
        emit(state.copyWith(showPassword: event.onChanged));
      }
      if(event is GetPasswordEvent){
        String password =  LocalDataUtils.instance.getString(SharedPreferencesKey.PASSWORD) ?? '';
        emit(state.copyWith(password: password,rememberPassword: password.isNotEmpty));
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
        response = await client.signIn(SignInRequest(state.username,state.password));
        success = true;
      }
      catch(error,stacktrace){
        message = handlingError(error, stacktrace);
      }
      if(success){
        LocalDataUtils.saveInformationLogin(response);
        if(state.rememberPassword) LocalDataUtils.savePassword(state.password);
        _getMe(response);
      }
      else{
          emit(state.copyWith(success: false,message: message,loading:false));
      }
    });
  }



  void _getMe(SignInResponse response) async{
    try{
      GetMeResponse response = await client.getMe();
      LocalDataUtils.saveInformationGetMe(response);
      emit(state.copyWith(success: true,loading: false));
    }
    catch(error,stacktrace){
      debugPrintStack(stackTrace: stacktrace);
      String message = handlingError(error, stacktrace);
      emit(state.copyWith(success:false,message: message));
    }
  }
}
