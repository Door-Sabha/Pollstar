import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:pollstar/ui/widgets/splash_widget.dart';
import 'package:pollstar/utils/analytics_manager.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/hive_manager.dart';
import 'package:pollstar/utils/secure_storage_manager.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    getIt<AppConstants>().init(context);
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
          home: FutureBuilder(
            future:
                getIt<SecureStorageManager>().hasValue(AppStrings.prefSession),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                User? user = getIt<HiveManager>().getUser();

                return (user != null)
                    ? HomeScreen(user: user)
                    : const LoginScreen();
              } else if (snapshot.hasData && snapshot.data == false) {
                return const LoginScreen();
              } else {
                return const SplashWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
