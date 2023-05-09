import 'package:authentication/network/get_me.dart';
import 'package:authentication/network/rest_client.dart';
import 'package:authentication/screen/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SplashBloc extends Bloc<SplashEvent,SplashState>{
  SplashBloc():super(SplashState()) {
    on<SplashEvent>((event, emit) async{
      emit(state.copyWith(loading: true));
      GetMeResponse response = await GetIt.instance<RestClient>().getMe();
      try{

      }
      catch(error){

      }
    });
  }
}

class SplashState {
  bool loading;
  GetMeResponse? response;

  SplashState({
    this.loading = false,
    this.response,
  });

  SplashState copyWith({
    bool? loading,
    GetMeResponse? response,
  }) {
    return SplashState(
      loading: loading ?? this.loading,
      response: response ?? this.response,
    );
  }
}

class SplashEvent {
}