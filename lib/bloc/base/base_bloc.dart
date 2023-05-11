import 'package:authentication/network/response.dart';
import 'package:authentication/network/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BaseBloc<BaseEvent,BaseState> extends Bloc<BaseEvent,BaseState>{
  RestClient client = GetIt.instance<RestClient>();
  BaseBloc(V) : super(V);

  String handlingError(Object error,StackTrace stacktrace) {
    String message = "Undefined Error";
    debugPrintStack(stackTrace: stacktrace);
    if (error is DioError) {
      switch (error.type) {
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
              error.response?.data);
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