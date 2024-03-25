import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/utils/broadcast_manager.dart';
import 'package:pollstar/utils/local_notification_manager.dart';

class FCMManager {
  FCMManager() {
    _setup();
  }

  _setup() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('FCM Foreground Message: ${message.notification?.body}');

      if (message.notification != null) {
        String? title = message.notification?.title;
        String? body = message.notification?.body;
        getIt<LocalNotificationManager>().show(title: title, body: body);
        final notification =
            BroadcastNotification("notification", {"type": "fcm"});
        BroadcastNotificationBloc.instance.newNotification(notification);
      }
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM Background Message: ${message.notification?.body}');
  if (message.notification != null) {
    String? title = message.notification?.title;
    String? body = message.notification?.body;
    getIt<LocalNotificationManager>().show(title: title, body: body);
  }
}
