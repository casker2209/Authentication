import 'package:authentication/bloc/base/base_state.dart';
import 'package:authentication/bloc/network/network_state.dart';
import 'package:authentication/network/response.dart';

class ChangePasswordState extends NetworkState<BaseResponse>{
  bool canClick;
  bool showOldPassword;
  bool showNewPassword;
  bool showConfirmedPassword;
  ChangePasswordState({required super.message, required super.success, required super.loading,super.response,this.canClick = false,this.showConfirmedPassword = false,this.showNewPassword = false,this.showOldPassword = false});

  @override
  ChangePasswordState copyWith({
    bool? canClick,
    bool? showOldPassword,
    bool? showNewPassword,
    bool? showConfirmedPassword,
    String? message, 
    bool? success,
    bool? loading,
    BaseResponse? response,
  }) {
    return ChangePasswordState(
      canClick: canClick ?? this.canClick,
      showOldPassword: showOldPassword ?? this.showOldPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmedPassword:
          showConfirmedPassword ?? this.showConfirmedPassword,
      message: message ?? this.message,
      loading: loading ?? this.loading,
      response : response ?? this.response, success: success ?? this.success,
    );
  }
}