import 'package:authentication/network/response.dart';
import 'package:authentication/network/rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/network/get_user.dart';
import 'package:get_it/get_it.dart';
class AccountListBloc extends Bloc<AccountListEvent,AccountListState>{
  AccountListBloc():super(AccountListState()) {
    on<AccountListEvent>((event,emit) async {
      if(event is GetUserEvent) {
        RestClient restClient = GetIt.instance<RestClient>();
        try {
          emit(state.copyWith(loading: true));
          GetUserResponse response = await restClient.getUser();
          emit(state.copyWith(
              loading: false, success: true, response: response));
        }
        on Error catch (e, st) {
          String message = ErrorHandlerUtils.handlingError(e, st);
          emit(
              state.copyWith(loading: false, success: false, message: message));
        }
      }

    });
  }
}

abstract class AccountListEvent {}

class GetUserEvent extends AccountListEvent{
}

class AccountListState{
  bool loading;
  BaseResponse? response;
  String message;
  bool success;
  AccountListState({this.response,this.loading = false,this.success = false,this.message = ""});

  AccountListState copyWith({
    bool? loading,
    BaseResponse? response,
    String? message,
    bool? success,
  }) {
    return AccountListState(
      loading: loading ?? this.loading,
      response: response ?? this.response,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }
}