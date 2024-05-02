// ignore_for_file: library_prefixes, avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart' as rxSub;
import 'package:timezone/timezone.dart' as tz;

/// TODO: IOS Setup

class NotificationClass {
  final int id;
  final String title;
  final String body;
  final String payload;
  NotificationClass({
    required this.id,
    required this.body,
    required this.payload,
    required this.title,
  });
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final rxSub.BehaviorSubject<NotificationClass>
    didReceiveLocalNotificationSubject =
    rxSub.BehaviorSubject<NotificationClass>();
final rxSub.BehaviorSubject<String> selectNotificationSubject =
    rxSub.BehaviorSubject<String>();

Future<void> initNotifications(
  FlutterLocalNotificationsPlugin notifsPlugin,
) async {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (
      int? id,
      String? title,
      String? body,
      String? payload,
    ) async {
      didReceiveLocalNotificationSubject.add(
        NotificationClass(
          id: id!,
          title: title!,
          body: body!,
          payload: payload!,
        ),
      );
    },
  );
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await notifsPlugin.initialize(
    initializationSettings,
    // onSelectNotification: (String? payload) async {
    //   if (payload != null) {
    //     print('notification payload: ' + payload);
    //     log('notification payload: ' + payload);
    //   }
    //   selectNotificationSubject.add(payload!);
    //   Get.toNamed('/Splash');
    // },
  );
  log("Notifications initialised successfully");
}

void requestIOSPermissions(FlutterLocalNotificationsPlugin notifsPlugin) {
  notifsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

Future<void> scheduleNotification({
  required FlutterLocalNotificationsPlugin notifsPlugin,
  required String id,
  required String title,
  required String body,
  required DateTime scheduledTime,
  bool fullscreen = false,
}) async {
  var androidSpecifics = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    icon: '@mipmap/ic_launcher',
    channelDescription: 'Events Notifications',
    channelShowBadge: true,
    priority: Priority.high,
    importance: Importance.max,
    ticker: 'ticker',
    sound: const RawResourceAndroidNotificationSound('alarm_bells'),
    fullScreenIntent: fullscreen,
    playSound: true,
    enableVibration: true,
    enableLights: true,
  );
  var iOSSpecifics = const DarwinNotificationDetails();
  var platformChannelSpecifics =
      NotificationDetails(android: androidSpecifics, iOS: iOSSpecifics);
  // ignore: deprecated_member_use
  await notifsPlugin.schedule(
    0,
    title,
    body,
    scheduledTime,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    payload: title,
  ); // This literally schedules the notification
}

Future<void> scheduleNotificationPeriodically(
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  String id,
  String body,
  RepeatInterval interval,
) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    icon: '@mipmap/ic_launcher',
    channelDescription: 'Events Notifications',
    channelShowBadge: true,
    priority: Priority.high,
    importance: Importance.max,
    sound: RawResourceAndroidNotificationSound('Alarm Bells.mp3'),
  );
  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.periodicallyShow(
    0,
    'Reminder',
    body,
    interval,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    payload: body,
  );
}

Future<void> scheduleDailyNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _nextInstanceOfTime(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
        enableLights: true,
        enableVibration: true,
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

Future<void> scheduleMondayNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _nextInstanceOfMonday(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        ticker: 'ticker',
        enableLights: true,
        icon: '@mipmap/ic_launcher',
        enableVibration: true,
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
  );
}

Future<void> scheduleTuesdayNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _nextInstanceOfTuesday(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        ticker: 'ticker',
        enableLights: true,
        enableVibration: true,
        icon: '@mipmap/ic_launcher',
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
  );
}

Future<void> scheduleWednesdayNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _nextInstanceOfWednesday(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        ticker: 'ticker',
        enableLights: true,
        icon: '@mipmap/ic_launcher',
        enableVibration: true,
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
  );
}

Future<void> scheduleThursdayNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _nextInstanceOfThursday(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        icon: '@mipmap/ic_launcher',
        ticker: 'ticker',
        enableLights: true,
        enableVibration: true,
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
  );
}

Future<void> scheduleFridayNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _nextInstanceOfFriday(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
        enableLights: true,
        enableVibration: true,
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
  );
}

Future<void> scheduleSaturdayNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _nextInstanceOfSaturday(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
        enableLights: true,
        enableVibration: true,
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
  );
}

Future<void> scheduleSundayNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _nextInstanceOfSunday(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
        enableLights: true,
        enableVibration: true,
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dateAndTime,
  );
}


Future<void> biMonthlyNotification({
  required String title,
  required String body,
  required String id,
  required bool fullscreen,
  required TimeOfDay time,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    _biMonthlyInstanceOfTime(time),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        playSound: true,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
        enableLights: true,
        enableVibration: true,
        channelShowBadge: true,
        fullScreenIntent: fullscreen,
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('alarm_bells'),
        channelDescription: 'daily notification reminder of recurring events.',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

_nextInstanceOfTime(TimeOfDay time) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

_biMonthlyInstanceOfTime(TimeOfDay time) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 15));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfMonday(TimeOfDay time) {
  tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
  while (scheduledDate.weekday != DateTime.monday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfTuesday(TimeOfDay time) {
  tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
  while (scheduledDate.weekday != DateTime.tuesday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfFriday(TimeOfDay time) {
  tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
  while (scheduledDate.weekday != DateTime.friday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfSaturday(TimeOfDay time) {
  tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
  while (scheduledDate.weekday != DateTime.saturday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfSunday(TimeOfDay time) {
  tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
  while (scheduledDate.weekday != DateTime.sunday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfWednesday(TimeOfDay time) {
  tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
  while (scheduledDate.weekday != DateTime.wednesday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfThursday(TimeOfDay time) {
  tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
  while (scheduledDate.weekday != DateTime.thursday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
