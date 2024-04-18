import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/answer.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/firebase_options.dart';
import 'package:pollstar/ui/auth/bloc/otp_request_bloc.dart';
import 'package:pollstar/ui/auth/bloc/otp_verification_bloc.dart';
import 'package:pollstar/ui/auth/login_screen.dart';
import 'package:pollstar/ui/help/bloc/help_bloc.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/ui/home/bloc/user_info_bloc.dart';
import 'package:pollstar/ui/home/home_screen.dart';
import 'package:pollstar/utils/analytics_manager.dart';
import 'package:pollstar/utils/broadcast_manager.dart';
import 'package:pollstar/utils/hive_manager.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
late FirebaseMessaging messaging;
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  messaging = FirebaseMessaging.instance;

  SystemChrome.setSystemUIOverlayStyle(AppStyle().systemUiOverlayStyle);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  getIt.registerSingleton(HiveManager());
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<StateInfo>(StateInfoAdapter());
  Hive.registerAdapter<UserParams>(UserParamsAdapter());
  Hive.registerAdapter<Answer>(AnswerAdapter());
  getIt<HiveManager>().userBox = await Hive.openBox(AppStrings.hiveBoxUser);
  getIt<HiveManager>().answerBox =
      await Hive.openBox(AppStrings.hiveBoxAnswers);

  await setupServiceLocator();

  /// FCM Integration
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await messaging.getToken();
  debugPrint(fcmToken);

  channel = const AndroidNotificationChannel(
    "${AppStrings.appName}_id",
    "${AppStrings.appName}_name",
    importance: Importance.high,
    enableLights: true,
    enableVibration: true,
    showBadge: true,
    playSound: true,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const android = AndroidInitializationSettings('@drawable/ic_logo');
  const iOS = DarwinInitializationSettings();
  const initSettings = InitializationSettings(android: android, iOS: iOS);

  await flutterLocalNotificationsPlugin!.initialize(initSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      String? title = message.notification?.title;
      String? body = message.notification?.body;

      showNotification(title: title, body: body, data: "");

      final notification =
          BroadcastNotification("notification", {"type": "fcm"});
      BroadcastNotificationBloc.instance.newNotification(notification);
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = getIt<HiveManager>().getUser();
    FlutterNativeSplash.remove();
    return RepositoryProvider(
      create: (context) => getIt<PollStarRepository>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OtpRequestBloc(
              RepositoryProvider.of<PollStarRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => OtpVerificationBloc(
              RepositoryProvider.of<PollStarRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => UserInfoBloc(
              RepositoryProvider.of<PollStarRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => QuestionListBloc(
              RepositoryProvider.of<PollStarRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => HelpBloc(
              RepositoryProvider.of<PollStarRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: AppStrings.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orangeColor),
            useMaterial3: true,
            //textTheme:
            //    GoogleFonts.firaSansTextTheme(ThemeData.light().textTheme),
            appBarTheme: AppBarTheme(
              foregroundColor: Colors.white,
              systemOverlayStyle: AppStyle().systemUiOverlayStyle,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: AppColors.textHintColor),
              floatingLabelStyle: TextStyle(color: AppColors.greenColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greenColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greenColor,
                  width: 2,
                ),
              ),
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.greenColor,
            ),
          ),
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            getIt<AnalyticsManager>().getFirebaseAnalyticsObserver()
          ],
          home: (user != null) ? HomeScreen(user: user) : const LoginScreen(),
        ),
      ),
    );
  }
}

Future<void> showNotification(
    {required String? title, required String? body, String? data}) async {
  final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  String? payload = data;
  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
    "${AppStrings.appName}_id",
    "${AppStrings.appName}_name",
    groupKey: AppStrings.appName,
    color: Colors.white,
    importance: Importance.high,
    playSound: true,
    priority: Priority.high,
    enableLights: true,
    enableVibration: true,
    icon: "@drawable/ic_logo",
  );

  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin!
      .show(id, title, body, notificationDetails, payload: payload);
}
