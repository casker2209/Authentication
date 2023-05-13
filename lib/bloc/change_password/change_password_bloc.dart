import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/change_password/change_password_event.dart';
import 'package:authentication/bloc/change_password/change_password_state.dart';
import 'package:authentication/bloc/network/network_bloc.dart';
import 'package:authentication/network/request/change_password.dart';
import 'package:authentication/network/response/response.dart';

class ChangePasswordBloc extends NetworkBloc<ChangePasswordEvent,ChangePasswordState>{
  ChangePasswordBloc():super(ChangePasswordState(message: '', success: false, loading: false)){
    on<ChangePasswordEvent>((event,emit) async{
      if(event is CheckShowOldPassword){
        emit(state.copyWith(showOldPassword: event.canShow));
      }
      else if(event is CheckShowNewPassword){
        emit(state.copyWith(showNewPassword: event.canShow));
      }
      else if(event is CheckShowConfirmedPassword){
        emit(state.copyWith(showConfirmedPassword: event.canShow));
      }
      else if(event is CheckCanClickEvent){
        emit(state.copyWith(canClick: event.canClick));
      }
      else if(event is ButtonPressedEvent){
        try{
          emit(state.copyWith(loading: true));
          BaseResponse response = await client.changePassword(ChangePasswordRequest(oldPassword:event.oldPassword,password:event.oldPassword));
          emit(state.copyWith(loading: true,success: true,response: response));
        }
        catch(error,stacktrace){
          String message = handlingError(error, stacktrace);
          emit(state.copyWith(success: false,message: message,loading: false));
        }
      }
    });
  }

}