import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/login.dart';
import '../network/rest_client.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  AuthenticationBloc() : super(AuthenticationState()){
    on<ShowPassword>((event,emit){
      emit(state.copyWith(showPassword:event.onChanged));
    });
    on<RememberPassword>((event,emit){
      emit(state.copyWith(rememberPassword:event.onChanged));
    });
    on<TextChanged>((event,emit){
      print("Text Changed");
      emit(state.copyWith(username: (event as TextChanged).username ?? state.username,password: event.password??state.password));
    });
    on<LoginButtonPressed>((event,emit) async{
      try{
        emit(state.copyWith(loading: true));
        SignInResponse response = await RestClient.client.signIn(SignInRequest(state.username!,state.password!));
        emit(state.copyWith(response: response));
      }
      catch(error,stacktrace){
        debugPrintStack(stackTrace:stacktrace);
      }
      finally{
        emit(state.copyWith(loading:false));
      }
    });
  }
}

class AuthenticationEvent{}

class LoginButtonPressed extends AuthenticationEvent{
}

class TextChanged extends AuthenticationEvent{
  String? username;
  String? password;
  TextChanged({String? username,String? password});
}

class ShowPassword extends AuthenticationEvent{
  ShowPassword(this.onChanged);
  bool onChanged;
}
class RememberPassword extends AuthenticationEvent{
  RememberPassword(this.onChanged);
  bool onChanged;
}

class AuthenticationState{
  AuthenticationState({
    String? username,String? password,SignInResponse? response,bool? showPassword,bool? rememberPassword,  bool? loading
  });
  String username = "";
  String password = "";
  bool showPassword = false;
  bool rememberPassword = false;
  bool loading = false;
  SignInResponse? response;

  AuthenticationState copyWith({
    String? username,
    String? password,
    bool? showPassword,
    bool? rememberPassword,
    SignInResponse? response,
    bool? loading
  }) {
    print(showPassword);
    print(this.showPassword);
    return AuthenticationState(
      username: username ?? this.username,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      rememberPassword: rememberPassword ?? this.rememberPassword,
      response: response ?? this.response,
      loading: loading ?? this.loading
    );
  }

  @override
  bool operator ==(Object other){
    bool b =  other is AuthenticationState && other.showPassword == showPassword && other.username == username;
    print("operator:"+b.toString());
    return b;
  }

}