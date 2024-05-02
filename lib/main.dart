// ignore_for_file: avoid_print


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Services/app_services.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:timezone/data/latest.dart';
import 'package:flutter_azure_tts/flutter_azure_tts.dart';

import 'Screens/splash_screen.dart';
import 'Theme/default_theme.dart';

// late NotificationAppLaunchDetails? notifLaunch;
// final FlutterLocalNotificationsPlugin notifsPlugin =
//     FlutterLocalNotificationsPlugin();
// late AndroidNotificationChannel channel;

initServices() async {
  await Get.putAsync(() => AppServices().init());
  await Get.putAsync(() => AuthServices().init());
  initializeTimeZones();
  // createAppDirectories();
  Get.log('===Local Notifications===');
  // notifLaunch = await notifsPlugin.getNotificationAppLaunchDetails();
  // await initNotifications(notifsPlugin);
  // if (GetPlatform.isIOS) requestIOSPermissions(notifsPlugin);
  Get.log('--Messaging Services--');
  // final pushNotificationService =
  //     PushNotificationService(FirebaseMessaging.instance);
  // PushNotificationService().initialise();
  Get.log('====Finished Initializing services====');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // channel = AndroidNotificationChannel(
  //   'high_importance_channel', // id
  //   'High Importance Notifications',
  //   importance: Importance.high,
  //   playSound: true,
  // );
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  await initServices();
  AzureTts.init( 
    subscriptionKey: Get.find<AppServices>().azure.subscriptionkey!,
    region: Get.find<AppServices>().azure.region!,
    withLogs: Get.find<AppServices>().azure.logs!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Thriving.org',
      theme: defaultTheme,
      darkTheme: darkTheme,
      home: const SplashScreen(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}


