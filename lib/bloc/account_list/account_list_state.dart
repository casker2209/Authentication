import 'package:authentication/bloc/network/network_state.dart';
import 'package:authentication/network/response/get_user.dart';
import 'package:authentication/network/response/response.dart';

class AccountListState extends NetworkState<BaseResponse>{
  List<User> users;
  AccountListState({super.response,super.loading = false,super.success = false,super.message = "",this.users = const []});

  AccountListState copyWith({
    bool? loading,
    BaseResponse? response,
    String? message,
    bool? success,
    List<User>? users
  }) {
    return AccountListState(
      loading: loading ?? super.loading,
      response: response ?? super.response,
      message: message ?? super.message,
      success: success ?? super.success,
      users:  users ?? this.users
    );
  }

  @override
  List get props => [loading,response,message,success,users];
}

class UpdateRemoveState extends NetworkState<BaseResponse>{
  int index;
  String? status;
  UpdateRemoveState({super.response,super.loading = false, super.success = false, super.message = "",required this.index,this.status});

  UpdateRemoveState copyWith({
    bool? loading,
    BaseResponse? response,
    String? message,
    bool? success,
    int? index,
    String? status
  }){return UpdateRemoveState(
  loading: loading ?? super.loading,
  response: response ?? super.response,
  message: message ?? super.message,
  success: success ?? super.success,
  status: status ?? this.status,
  index: index ?? this.index
  );}


  @override
  List get props => [loading,response,message,success,index,status];
}