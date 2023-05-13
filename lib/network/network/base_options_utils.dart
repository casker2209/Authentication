import 'package:authentication/network/network/base_options_utils.dart';
import 'package:dio/dio.dart';

class BaseOptionsUtils{
  static BaseOptions defaultBaseOptions =  BaseOptions(
      headers: {
        'content-Type':'application/json',
        'Accept':'*/*'
      },
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60)
  );
}