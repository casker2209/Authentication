import 'package:authentication/bloc/base/base_state.dart';
import 'package:authentication/bloc/network/network_state.dart';
import 'package:authentication/network/get_user.dart';
import 'package:authentication/network/response.dart';
class CreateUserState extends NetworkState<BaseResponse> {
  bool showPassword;
  bool canClick;
  User? user;
  CreateUserState(
      {required this.showPassword,required super.loading,super.response, required super.message, required super.success,this.canClick = false,this.user}
      );


  @override
  CreateUserState copyWith({
    bool? loading,
    String? message,
    BaseResponse? response,
    bool? success,
    bool? showPassword,
    bool? canClick,
    User? user

  }) {
    return CreateUserState(
        loading: loading ?? super.loading,
        success: success ?? super.success,
        response: response ?? this.response,
        message: message ?? super.message,
        showPassword: showPassword ?? this.showPassword,
      canClick: canClick ?? this.canClick,
      user:user ?? this.user
    );
  }


  @override
  // TODO: implement props
  List get props => [loading,showPassword,success,loading,message,canClick,user];

}