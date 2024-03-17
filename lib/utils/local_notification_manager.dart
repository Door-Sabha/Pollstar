import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pollstar/utils/strings.dart';

class LocalNotificationManager {
  late final FlutterLocalNotificationsPlugin _notificationsPlugin;
  LocalNotificationManager() {
    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    _init();
  }

  _init() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('drawable/ic_logo');
    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );
  }

  _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('onDidReceiveLocalNotification Title $title');
    show(title: title, body: body, data: payload);
  }

  _onDidReceiveNotificationResponse(NotificationResponse res) async {
    final String? payload = res.payload;
    if (res.payload != null) {
      _processNotification(payload!);
      print('onDidReceiveNotificationResponse payload: $payload');
    }
  }

  static _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse res) async {
    final String? payload = res.payload;
    if (res.payload != null) {
      //_processNotification(payload!);
      print('onDidReceiveBackgroundNotificationResponse payload: $payload');
    }
  }

  _processNotification(String payload) {
    //show(title: AppStrings.appName, body: payload);
  }

  Future<void> show(
      {required String? title, required String? body, String? data}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String? payload = data;
      AndroidNotificationDetails androidNotificationDetails =
          const AndroidNotificationDetails(
        "${AppStrings.appName}_id",
        "${AppStrings.appName}_name",
        groupKey: AppStrings.appName,
        color: Colors.white,
        importance: Importance.max,
        playSound: true,
        priority: Priority.high,
        icon: "@drawable/ic_logo",
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );

      await _notificationsPlugin.show(id, title, body, notificationDetails,
          payload: payload);
    } catch (e) {
      print(e);
    }
  }
}

onDidReceiveBackgroundNotificationResponse(NotificationResponse res) {
  final String? payload = res.payload;
  if (res.payload != null) {
    print('onDidReceiveBackgroundNotificationResponse payload: $payload');
  }
}
