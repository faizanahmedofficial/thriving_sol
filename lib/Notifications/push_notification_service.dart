// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // PushNotificationService(this._fcm);

  Future initialise() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('authorized');
      } else {
        print('User declined or has not accepted permission');
      }
    }
  }

  // If you want to test the push notification locally,
  // you need to get the token and input to the Firebase console
  // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
  // String token = await _fcm.getToken();
  // print("FirebaseMessaging token: $token");
  // _fcm.getNotificationSettings();

  // _fcm.configure(
  //   onMessage: (Map<String, dynamic> message) async {
  //     print("onMessage: $message");
  //   },
  //   onLaunch: (Map<String, dynamic> message) async {
  //     print("onLaunch: $message");
  //   },
  //   onResume: (Map<String, dynamic> message) async {
  //     print("onResume: $message");
  //   },
  // );
  // }
}
