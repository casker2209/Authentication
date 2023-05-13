import 'package:authentication/utils/dialog_utils.dart';
import 'package:authentication/utils/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication/network/local/local_data_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService{
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
        LocalDataUtils.clearLogin();
      }
    });
  }

  static void signOut(){
    LocalDataUtils.clearLogin();
    GoRouterUtils.navState.currentContext!.go("/authentication");
  }

  static void handleMessage(RemoteMessage message){
    if(message.data['type'] == "logout"){
      DialogUtils.showButtonDialog(
          title:"Test message, vui lòng đăng nhập lại",
          onClick: signOut
      );
    }
  }
  static void handleMessageBackground(RemoteMessage message){
    LocalDataUtils.clearLogin();
  }

}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FirebaseService.handleMessageBackground(message);
}


