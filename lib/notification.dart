// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationApp {
  static bool enableNoti = false;
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // static final localNotification = FlutterLocalNotificationsPlugin();
  static Future<void> initNotification() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/ic_launcher',
        [
          NotificationChannel(
            channelGroupKey: 'default_notification_channel_id',
            channelKey: 'default_notification_channel_id',
            channelName: 'SKLE',
            importance: NotificationImportance.High,
            locked: false,
            channelDescription: 'SKLE notification channel',
          )
        ],
        debug: true);
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      enableNoti = true;
      final token = await messaging.getToken();
      print(token);
      FirebaseMessaging.onMessage.listen((result) {
        // final title = result.notification?.title ?? '';
        // final body = result.notification?.body ?? '';
        // showMessageNoti(title, body);
      });
      AwesomeNotifications().actionStream.listen((data) {
        print(data);
      });
    }
  }

  static void showMessageNoti(String message) {
    if (enableNoti) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 10,
        channelKey: 'default_notification_channel_id',
        title: 'SKLE',
        body: message,
        displayOnForeground: true,
        payload: {"type": "message"},
        criticalAlert: true,
        category: NotificationCategory.Message,
        showWhen: true,
        wakeUpScreen: true,
      ));
    }
  }
}
