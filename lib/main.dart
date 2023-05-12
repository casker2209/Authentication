import 'package:authentication/firebase_options.dart';
import 'package:authentication/network/rest_client.dart';
import 'package:authentication/screen/login/authentication_screen.dart';
import 'package:authentication/utils/color.dart';
import 'package:authentication/utils/firebase_messaging_utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/go_router.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await GetIt.instance.allReady();
  router = await GoRouterUtils.getRouter();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}
late GoRouter router;
void setup() async{
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<RestClient>(() => RestClient(Dio(
    BaseOptions(
        headers: {
          'content-Type':'application/json',
          'Accept':'*/*'
        },
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60)
    ),
  )..interceptors.addAll([
    PrettyDioLogger(requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90),
    AuthInterceptor()
  ]
  )
  ));
  getIt.registerSingletonAsync<SharedPreferences>(() async{
    return await SharedPreferences.getInstance();
  });
  getIt.registerSingleton<GoRouterUtils>(GoRouterUtils());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUtils.setup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(primary: UtilsColor.colorGreenPrimary)
      ),
    );
  }
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FirebaseUtils.handleMessage(message);
}

