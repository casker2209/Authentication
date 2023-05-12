import 'package:authentication/utils/dialog_utils.dart';
import 'package:authentication/utils/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseUtils{
  static void setup() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("fcmToken: "+fcmToken.toString());
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
    })
        .onError((err) {
    });
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((message) async{
      if(message.data['type'] == "logout"){
        handleMessage(message);
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if(event.data['type'] == "logout"){
        SharedPreferencesUtils.clearLogin();
      }
    });
  }

  static void signOut(){
    SharedPreferencesUtils.clearLogin();
    GoRouterUtils.navState.currentContext!.go("/authentication");
  }

  static void handleMessage(RemoteMessage message){
    if(message.data['type'] == "logout"){
      DialogUtils.showCustomDialog("Test message, vui lòng đăng nhập lại",widgetTop:Icon(Icons.error_outline,color: Colors.red,size: 30),
      widgetBottom: Material(
        child: InkWell(
          onTap: (){
            signOut();
          },
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Center(child: Text("OK"))),
        ),
      )

      );
    }
  }
  static void handleMessageBackground(RemoteMessage message){
    SharedPreferencesUtils.clearLogin();
  }

}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FirebaseUtils.handleMessageBackground(message);
}


