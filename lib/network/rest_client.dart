import 'dart:async';

import 'package:authentication/network/change_password.dart';
import 'package:authentication/network/create_user.dart';
import 'package:authentication/network/get_user.dart';
import 'package:authentication/network/response.dart';
import 'package:authentication/network/update_user.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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
  @PUT("/api/users/{id}")
  Future<BaseResponse> updateUser(@Body() UpdateUserRequest request,@Path("id") String userId);
  @POST("/api/users")
  Future<BaseResponse> createUser(@Body() CreateUserRequest request);
  @GET("/api/users")
  Future<GetUserResponse> getUser();
  @DELETE("/api/users/{id}")
  Future<BaseResponse> deleteUser(@Path("id") String userId);
  @POST("/api/users/me/change-password")
  Future<BaseResponse> changePassword(@Body() ChangePasswordRequest request);

}

class ErrorHandlerUtils{
  static String handlingError(Error error,StackTrace stacktrace){
    String message = "Undefined Error";
    debugPrintStack(stackTrace:stacktrace);
    if(error is DioError) {
      switch ((error as DioError).type) {
        case DioErrorType.cancel:
          message = "Request to API server was cancelled";
          break;
        case DioErrorType.connectionTimeout:
          message = "Connection timeout with API server";
          break;
        case DioErrorType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioErrorType.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        case DioErrorType.badResponse:
          var badResponse = BaseResponse.BaseResponseFromJsonWithErrorHandling(
              (error as DioError).response?.data);
          message = badResponse != null ? badResponse.message! : "Bad Request";
          break;
        case DioErrorType.connectionError:
          message = "Unexpected error occurred. Cannot connected to server";
          break;
        case DioErrorType.unknown:
          if ((error as DioError).error != null &&
              (error as DioError).type.toString().contains("SocketException")) {
            message = 'No Internet';
            break;
          }
          message = "Unexpected error occurred";
          break;
        default:
          message = "Something went wrong";
          break;
      }
    }
    return message;
  }
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
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}

class ErrorHandlingInterceptor extends Interceptor{
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
