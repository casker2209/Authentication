import 'dart:convert';

import 'package:authentication/network/response/login_response.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKey{
  static const String TOKEN_HADU = "TOKEN";
  static const String ROLE = "ROLE";
  static const String USER_ID_ROCKET = "USER_ID_ROCKET";
  static const String TOKEN_ROCKET = "TOKEN_ROCKET";
  static const String GET_ME = "GET_ME";
  static const String PASSWORD = "PASSWORD";

}