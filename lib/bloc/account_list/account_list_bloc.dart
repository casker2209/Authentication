import 'package:authentication/bloc/account_list/account_list_bloc.dart';
import 'package:authentication/bloc/account_list/account_list_event.dart';
import 'package:authentication/bloc/account_list/account_list_state.dart';
import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/network/response.dart';
import 'package:authentication/network/rest_client.dart';
import 'package:authentication/network/update_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/network/get_user.dart';
import 'package:get_it/get_it.dart';
class AccountListBloc extends BaseBloc<AccountListEvent,AccountListState>{
  AccountListBloc():super(AccountListState()) {
    on<AccountListEvent>((event,emit) async {
      if(event is GetUserEvent) {
        RestClient restClient = GetIt.instance<RestClient>();
        try {
          emit(state.copyWith(loading: true));
          GetUserResponse response = await restClient.getUser();
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
          emit(state.copyWith(users:List.of(state.users..removeAt(event.index))));
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

class UpdateRemoveUserBloc extends BaseBloc<UpdateRemoveEvent,UpdateRemoveState>{
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
