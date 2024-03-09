import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/utils/app_constants.dart';

class FCMManager {
  FCMManager() {
    _setup();
    _registerListener();
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
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    getIt<AppConstants>().fcmToken = fcmToken;
  }

  _registerListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
      "Handling a background message: ${message.notification} ${message.category} ${message.data} ${message.messageType}");
}