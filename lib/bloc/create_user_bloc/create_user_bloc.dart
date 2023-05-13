import 'dart:math';

import 'package:authentication/bloc/authentication/authentication_event.dart';
import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/create_user_bloc/create_user_bloc.dart';
import 'package:authentication/bloc/create_user_bloc/create_user_event.dart';
import 'package:authentication/bloc/create_user_bloc/create_user_state.dart';
import 'package:authentication/bloc/network/network_bloc.dart';
import 'package:authentication/network/request/create_user.dart';
import 'package:authentication/network/request/update_user.dart';
import 'package:authentication/network/response/get_user.dart';
import 'package:authentication/network/response/response.dart';
import 'package:authentication/utils/request_permission_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CreateUserBloc extends NetworkBloc<CreateUserEvent,CreateUserState>{
  User? user;
  CreateUserBloc({this.user}):super(CreateUserState(loading:false, message: '', success: false,showPassword:false,user:user)){
    on<CreateUserEvent>((event, emit) async{
      if(event is TextChangedEvent){
      }
      else if(event is CheckConditionEvent){
        emit(state.copyWith(canClick: event.canClick));
      }
      else if(event is ButtonPressedEvent){
        try{
          emit(state.copyWith(loading: true));
          BaseResponse response;
          if(user!=null){
            String? password;
            if(event.password.isNotEmpty) password = event.password;
            response = await client.updateUser(UpdateUserRequest(username:event.phoneNumber,name:event.name,password: password),user!.username!);}
          else{
            response = await client.createUser(CreateUserRequest(username:event.phoneNumber,name:event.name,password: event.password));
          }
          emit(state.copyWith(response:response,loading: false,success: true));
        }
        catch(e,stacktrace){
          String message = handlingError(e, stacktrace);
          emit(state.copyWith(loading: false,success: false,message:message));
        }
      }
      else if(event is GetContactEvent){
        }
      else if(event is ShowPasswordEvent){
       emit(state.copyWith(showPassword:event.show));
      }
      else if(event is DefaultPasswordEvent){

      }
    });
  }
}

