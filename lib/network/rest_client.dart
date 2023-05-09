import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'login.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://node.stpsoftwares.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static final RestClient client = RestClient(Dio(
    BaseOptions(
      headers: {
        'content-Type':'application/json'
      }
    ),
  )..interceptors.add(LogInterceptor(responseBody: true,requestBody: true,request: true)));
  @POST("/api/auth/singin")
  FutureOr<SignInResponse> signIn(@Body() SignInRequest request);
}

