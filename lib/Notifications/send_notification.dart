// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;


Future<bool> sendtNotification(
    {required String title,
    required String body,
    required String deviceToken}) async {
  try {
    http.Response response;
    String url = 'https://fcm.googleapis.com/fcm/send';
    String server =
        'AAAAtAsqjtY:APA91bFwESgpuiulyR2ooKzKm9oZYsnis1Eix7OI5kWpHv-owrdJQ5DAYcy1njYSrPwQ6i6wUgbqNaR_QQeRzfqSAFRMibg9CkE209UYINdOHGpNnRtOAnPva61Ho15eeiwzslvMWNaS';
    // for (int i = 0; i < songModelOffline.curatorDeviceId.length; i++) {
    var message = {
      "to": deviceToken,
      "collapse_key": "type_a",
      "notification": {"title": title, "body": body, "sound": "default"},
      "data": {
        "title": title,
        "body": body,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      // "to": "/topics/songs",
      "priority": "high"
    };
    response = await http.post(
      Uri.parse(url),
      headers: {
        "content-type": "application/json; charset=UTF-8",
        "Authorization": "key=$server"
      },
      body: json.encode(message),
    );
    // }
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      print('Notification sent');
      return true;
    } else {
      print('did not send');
      return false;
    }
  } catch (e) {
    print('FCM ERROR: $e');
    return false;
  }
}

Future<bool> sendMultipleNotification(
    {required String title,
    required String body,
    required List<String> deviceTokens}) async {
  try {
    late http.Response response;
    String url = 'https://fcm.googleapis.com/fcm/send';
    String server =
        'AAAAtAsqjtY:APA91bFwESgpuiulyR2ooKzKm9oZYsnis1Eix7OI5kWpHv-owrdJQ5DAYcy1njYSrPwQ6i6wUgbqNaR_QQeRzfqSAFRMibg9CkE209UYINdOHGpNnRtOAnPva61Ho15eeiwzslvMWNaS';
    for (int i = 0; i < deviceTokens.length; i++) {
      var message = {
        "to": deviceTokens[i],
        "collapse_key": "type_a",
        "notification": {
          "title": "New Song Submission",
          "body": "A song has been submitted to you",
          "sound": "default"
        },
        "data": {
          "title": "New Song Submission",
          "body": "A song has been submitted to you",
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        // "to": "/topics/songs",
        "priority": "high"
      };
      response = await http.post(
        Uri.parse(url),
        headers: {
          "content-type": "application/json; charset=UTF-8",
          "Authorization": "key=$server"
        },
        body: json.encode(message),
      );
    }
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      print('Notification sent');
      return true;
    } else {
      print('did not send');
      return false;
    }
  } catch (e) {
    print('FCM ERROR: $e');
    return false;
  }
}
