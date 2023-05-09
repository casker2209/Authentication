import 'dart:async';

import 'package:authentication/network/create_user.dart';
import 'package:authentication/network/get_user.dart';
import 'package:authentication/network/response.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:retrofit/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'get_me.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://node.stpsoftwares.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  @POST("/api/auth/singin")
  Future<SignInResponse> signIn(@Body() SignInRequest request);
  @GET("/api/users/me")
  Future<GetMeResponse> getMe();
  @POST("/api/users")
  Future<BaseResponse> createUser(@Body() CreateUserRequest request);
  @GET("/api/users")
  Future<GetUserResponse> getUser();
}

class AuthInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    SharedPreferences preferences = GetIt.instance<SharedPreferences>();
    if(preferences.containsKey(SharedPreferencesKey.TOKEN_ROCKET)){
      options.headers.addAll(
          {
            "Authorization-Rocket":preferences.getString(SharedPreferencesKey.TOKEN_ROCKET),
            "X-Auth-Token":preferences.getString(SharedPreferencesKey.TOKEN_ROCKET),
          });
    }
    if(preferences.containsKey(SharedPreferencesKey.TOKEN_HADU)){
      options.headers.addAll({"Authorization":"Bearer ${preferences.getString(SharedPreferencesKey.TOKEN_HADU)}"});
    }
    if(preferences.containsKey(SharedPreferencesKey.USER_ID_ROCKET)){
      options.headers.addAll({"X-User-Id":"Bearer ${preferences.getString(SharedPreferencesKey.USER_ID_ROCKET)}"});
    }
  }
}

class ErrorHandlingInterceptor extends Interceptor{
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
