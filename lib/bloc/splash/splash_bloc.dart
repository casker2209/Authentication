import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/splash/splash_bloc.dart';
import 'package:authentication/bloc/splash/splash_event.dart';
import 'package:authentication/bloc/splash/splash_state.dart';
import 'package:authentication/network/get_me.dart';
import 'package:authentication/network/rest_client.dart';
import 'package:authentication/screen/splash.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends BaseBloc<SplashEvent,SplashState>{
  SplashBloc():super(SplashState()) {
    on<SplashEvent>((event, emit) async{
      try{
        emit(state.copyWith(loading: true));
        GetMeResponse response = await GetIt.instance<RestClient>().getMe();
        SharedPreferencesUtils.saveInformationGetMe(response);
        emit(state.copyWith(response: response,success:true,loading:false));
      }
      catch(e,stacktrace){
        String message = handlingError(e, stacktrace);
        emit(state.copyWith(loading: false,success: false,message:message));
      }
    });
  }
}
