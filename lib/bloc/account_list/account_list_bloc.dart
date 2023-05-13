import 'package:authentication/bloc/account_list/account_list_bloc.dart';
import 'package:authentication/bloc/account_list/account_list_event.dart';
import 'package:authentication/bloc/account_list/account_list_state.dart';
import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/network/network_bloc.dart';
import 'package:authentication/network/request/update_user.dart';
import 'package:authentication/network/response/get_user.dart';
import 'package:authentication/network/response/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
class AccountListBloc extends NetworkBloc<AccountListEvent,AccountListState>{
  AccountListBloc():super(AccountListState()) {
    on<AccountListEvent>((event,emit) async {
      if(event is GetUserEvent) {
        try {
          emit(state.copyWith(loading: true));
          GetUserResponse response = await client.getUser();
          emit(state.copyWith(
              loading: false, success: true, response: response,users:response.data));
        }
        on Error catch (e, st) {
          String message = handlingError(e, st);
          emit(state.copyWith(loading: false, success: false, message: message));
        }
      }
      else if(event is UpdateRemoveUserEvent){
        if(event.status == null){
          List<User> users = List.from(state.users..removeAt(event.index));
          emit(state.copyWith(users:[]));
          emit(state.copyWith(users:users));
        }
        else{
          List<User> users = List.from(state.users);
          users[event.index].status = event.status;
          var state2 = state.copyWith(users:users);
          emit(state.copyWith(users:[]));
          emit(state2);
        }
      }
      }

    );
  }
}

class UpdateRemoveUserBloc extends NetworkBloc<UpdateRemoveEvent,UpdateRemoveState>{
  UpdateRemoveUserBloc():super(UpdateRemoveState(index: -1)){
    on<UpdateRemoveEvent>((event,emit) async{
      if(event is UpdateUserEvent){
        try {
          emit(state.copyWith(loading: true));
          BaseResponse response = await client.updateUser(UpdateUserRequest(status: event.status), event.id);
          emit(state.copyWith(loading: false, success: true, response: response,index: event.index,status: event.status));
        }
        catch (e, st) {
          String message = handlingError(e, st);
          emit(state.copyWith(loading: false, success: false, message: message));
        }
      }
      else if(event is DeleteUserEvent){
        try {
          emit(state.copyWith(loading: true));
          BaseResponse response = await client.deleteUser(event.id);
          emit(state.copyWith(loading: false, success: true, response: response,index: event.index));
        }
         catch (e, st) {
          String message = handlingError(e, st);
          emit(state.copyWith(loading: false, success: false, message: message));
        }
      }
    });
  }
}
