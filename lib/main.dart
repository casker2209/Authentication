import 'package:authentication/network/rest_client.dart';
import 'package:authentication/screen/login/authentication_screen.dart';
import 'package:authentication/utils/Color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/go_router.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await GetIt.instance.allReady();
  runApp(const MyApp());
}

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
    LogInterceptor(responseBody: true,requestBody: true,request: true),
    AuthInterceptor()
  ]
  )
  ));
  getIt.registerSingletonAsync<SharedPreferences>(() async{
    return await SharedPreferences.getInstance();
  });
  getIt.registerSingleton<GoRouterUtils>(GoRouterUtils());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouterUtils.router,
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(primary: UtilsColor.colorGreenPrimary)
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
