import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/ui/auth/bloc/otp_request_bloc.dart';
import 'package:pollstar/ui/auth/bloc/otp_verification_bloc.dart';
import 'package:pollstar/ui/auth/login_screen.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(AppStyle().systemUiOverlayStyle);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        ],
        child: MaterialApp(
          title: AppStrings.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orangeColor),
            useMaterial3: true,
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
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
