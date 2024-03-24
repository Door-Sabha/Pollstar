import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/utils.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationManager {
  late final FlutterLocalNotificationsPlugin _notificationsPlugin;
  LocalNotificationManager() {
    tz.initializeTimeZones();
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
        priority: Priority.max,
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

  Future<void> scheduleNotification(Question question,
      {bool isTest = false}) async {
    if (isTest == false &&
        (question.questionTime == null ||
            question.questionTime!.trigger == null)) {
      return;
    }

    await _notificationsPlugin.zonedSchedule(
      question.id ?? 0,
      AppStrings.appName,
      question.text,
      tz.TZDateTime.from(
        (isTest)
            ? DateTime.now().add(const Duration(seconds: 5))
            : AppUtils().getDateTimeFromString(question.questionTime!.trigger!),
        tz.local,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "${AppStrings.appName}_id",
          "${AppStrings.appName}_name",
          channelDescription: "ashwin",
          groupKey: AppStrings.appName,
          color: Colors.white,
          importance: Importance.max,
          playSound: true,
          priority: Priority.max,
          icon: "@drawable/ic_logo",
        ),
        iOS: DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> clearScheduledNotification() async {
    await _notificationsPlugin.cancelAll();
  }
}
