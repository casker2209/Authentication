import 'dart:convert';

import 'package:authentication/network/get_me.dart';
import 'package:authentication/network/login.dart';
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

class SharedPreferencesUtils{
  static SharedPreferences get instance => GetIt.instance<SharedPreferences>();
  static void saveInformationLogin(SignInResponse response) async{
    SharedPreferences preferences = await GetIt.instance<SharedPreferences>();
    preferences.setString(SharedPreferencesKey.TOKEN_HADU, response.system!.token!);
    preferences.setString(SharedPreferencesKey.ROLE, response.system!.role!);
    preferences.setString(SharedPreferencesKey.TOKEN_ROCKET,response.rocket!.data!.authToken!);
    preferences.setString(SharedPreferencesKey.USER_ID_ROCKET, response.rocket!.data!.userId!);
  }
  static void savePassword(String password) async{
    await GetIt.instance<SharedPreferences>().setString(SharedPreferencesKey.PASSWORD, password);
  }
  static Future<bool> loggedIn() async{
    SharedPreferences preferences = await GetIt.instance<SharedPreferences>();
    return preferences.containsKey(SharedPreferencesKey.TOKEN_HADU)
    && preferences.containsKey(SharedPreferencesKey.ROLE)
    && preferences.containsKey(SharedPreferencesKey.TOKEN_ROCKET)
    && preferences.containsKey(SharedPreferencesKey.USER_ID_ROCKET);
  }
  static void clearLogin() async{
  SharedPreferences preferences = await GetIt.instance<SharedPreferences>();
   preferences.remove(SharedPreferencesKey.TOKEN_HADU);
   preferences.remove(SharedPreferencesKey.ROLE);
   preferences.remove(SharedPreferencesKey.TOKEN_ROCKET);
   preferences.remove(SharedPreferencesKey.USER_ID_ROCKET);
   preferences.remove(SharedPreferencesKey.PASSWORD);
}
  static void saveInformationGetMe(GetMeResponse response) async{
  SharedPreferences preferences = await GetIt.instance<SharedPreferences>();
  preferences.setString(SharedPreferencesKey.GET_ME, json.encode(response.toJson()));
  /*preferences.setString(SharedPreferencesKey.TOKEN_HADU, response.system!.token!);
  preferences.setString(SharedPreferencesKey.ROLE, response.system!.role!);
  preferences.setString(SharedPreferencesKey.TOKEN_ROCKET,response.rocket!.data!.authToken!);
  preferences.setString(SharedPreferencesKey.USER_ID_ROCKET, response.rocket!.data!.userId!);*/

  }
  static Future<GetMeResponse?> getMe() async {
    SharedPreferences preferences = await GetIt.instance<SharedPreferences>();
    if(!preferences.containsKey(SharedPreferencesKey.GET_ME)) return null;
    return GetMeResponse.fromJson(json.decode(preferences.getString(SharedPreferencesKey.GET_ME)!));
  }
}