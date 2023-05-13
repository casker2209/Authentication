import 'package:authentication/bloc/base/base_state.dart';
import 'package:authentication/bloc/network/network_state.dart';
import 'package:authentication/network/response/login_response.dart';
import 'package:authentication/network/response/response.dart';

class AuthenticationState extends NetworkState<SignInResponse>{
  AuthenticationState({
    required this.username,
    required this.password,
    super.response,
    required this.showPassword,
    required this.rememberPassword,
    required super.loading, required super.message, required super.success
  });

  String username;
  String password;
  bool showPassword;
  bool rememberPassword;

  bool get canLogin => username.isNotEmpty && password.isNotEmpty;

  @override
  List get props => [showPassword,loading,rememberPassword,username,password,response,success,message];

  AuthenticationState copyWith({
    String? username,
    String? password,
    bool? showPassword,
    bool? rememberPassword,
    bool? loading,
    SignInResponse? response,
    BaseResponse? errorResponse,
    String? message,
    bool? success,
  }) {
    return AuthenticationState(
      username: username ?? this.username,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      rememberPassword: rememberPassword ?? this.rememberPassword,
      loading: loading ?? this.loading,
      response: response ?? this.response,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }
}