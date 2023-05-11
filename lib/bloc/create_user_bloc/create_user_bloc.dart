import 'dart:math';

import 'package:authentication/bloc/authentication/authentication_event.dart';
import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/create_user_bloc/create_user_bloc.dart';
import 'package:authentication/bloc/create_user_bloc/create_user_event.dart';
import 'package:authentication/bloc/create_user_bloc/create_user_state.dart';
import 'package:authentication/network/create_user.dart';
import 'package:authentication/network/get_user.dart';
import 'package:authentication/network/response.dart';
import 'package:authentication/network/rest_client.dart';
import 'package:authentication/network/update_user.dart';
import 'package:authentication/utils/request_permission_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get_it/get_it.dart';

class CreateUserBloc extends BaseBloc<CreateUserEvent,CreateUserState>{
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
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
            response = await client.updateUser(UpdateUserRequest(username:event.phoneNumber,name:event.name,password: event.password),user!.username!);}
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
          //bool permission = await RequestPermissionUtils.requestContact();
          //if(permission){
            /*Contact? contact = await _contactPicker.selectContact();
            print(contact.toString());
            if(contact!=null){
              emit(state.copyWith(
                  username: contact.phoneNumbers!=null && contact.phoneNumbers!.isNotEmpty ? contact.phoneNumbers!.first : "",
                  name: contact.fullName?? ""));
            }
          //}*/
        }
      else if(event is ShowPasswordEvent){
       emit(state.copyWith(showPassword:event.show));
      }
      else if(event is DefaultPasswordEvent){

      }
    });
  }
}

