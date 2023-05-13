import 'package:authentication/bloc/base/base_state.dart';
import 'package:authentication/bloc/network/network_state.dart';
import 'package:authentication/network/response/get_me.dart';

class SplashState extends NetworkState<GetMeResponse>{
  SplashState(
      {super.loading = false,super.response, super.message = "", super.success = false}
      );


  @override
  SplashState copyWith({
    bool? loading,
    String? message,
    GetMeResponse? response,
    bool? success,

  }) {
    return SplashState(
        loading: loading ?? super.loading,
        success: success ?? super.success,
        response: response ?? this.response,
        message: message ?? super.message,
    );
  }


  @override
  // TODO: implement props
  List get props => [loading,success,loading,message];
}