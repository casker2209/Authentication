import 'package:authentication/network/get_user.dart';
import 'package:authentication/screen/account_list/account_list_screen.dart';
import 'package:authentication/screen/create_user/create_user_screen.dart';
import 'package:authentication/screen/login/authentication_screen.dart';
import 'package:authentication/screen/splash.dart';
import 'package:authentication/screen/home.dart';
import 'package:authentication/screen/success/success_screen.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoRouterUtils {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

  static final router = GoRouter(
      navigatorKey: navState,
      routes: [
        GoRoute(
            path: "/",
            builder: (context, state) => SplashScreen()),
        GoRoute(
          path: "/authentication",
          builder: (context, state) => AuthenticationScreen(),
        ),
        GoRoute(
            path: "/home",
            builder: (context, state) => HomeScreen()
        ),
        GoRoute(
            path: "/users",
            builder: (context, state) => AccountListScreen()
        ),
        GoRoute(
          path:"/success",
          builder: (context,state) => SuccessScreen(isCreate:state.extra==true)
        ),
        GoRoute(
          path:"/create",
          builder: (context,state) => CreateUserScreen(user: state.extra as User?)
        ),
        GoRoute(
          path:"/splash",
          builder:(context,state) => SplashScreen()
        )
      ],
    initialLocation:  "/splash"
  );

  static Future<GoRouter> getRouter() async{
    return GoRouter(
        navigatorKey: navState,
        routes: [
    GoRoute(
    path: "/",
    builder: (context, state) => SplashScreen()),
    GoRoute(
    path: "/authentication",
    builder: (context, state) => AuthenticationScreen(),
    ),
    GoRoute(
    path: "/home",
    builder: (context, state) => HomeScreen()
    ),
    GoRoute(
    path: "/users",
    builder: (context, state) => AccountListScreen()
    ),
    GoRoute(
    path:"/success",
    builder: (context,state) => SuccessScreen(isCreate:state.extra==true)
    ),
    GoRoute(
    path:"/create",
    builder: (context,state) => CreateUserScreen(user: state.extra as User?)
    ),
    GoRoute(
    path:"/splash",
    builder:(context,state) => SplashScreen()
    )
    ],
    initialLocation:await SharedPreferencesUtils.loggedIn() ? "/splash" : "/authentication"
    //"/create"
     );
  }
  void goUsers(context){
    context.go("/home");
  }
  void goLogin(context){
    context.go("/authentication");
  }

}