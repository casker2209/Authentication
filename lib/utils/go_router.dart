import 'package:authentication/screen/account_list/account_list_screen.dart';
import 'package:authentication/screen/create_user/create_user_screen.dart';
import 'package:authentication/screen/login/authentication_screen.dart';
import 'package:authentication/screen/splash.dart';
import 'package:authentication/screen/home.dart';
import 'package:go_router/go_router.dart';

class GoRouterUtils {
  static final router = GoRouter(
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
          path:"/create",
          builder: (context,state) => CreateUserScreen()
        )
      ],
    initialLocation: "/create"
  );

  void goUsers(context){
    context.go("/users");
  }
  void goLogin(context){
    context.go("/authentication");
  }
}