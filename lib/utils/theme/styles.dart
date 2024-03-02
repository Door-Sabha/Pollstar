import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppStyle {
  get systemUiOverlayStyle => const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark, //iOS top bar color
        statusBarColor: Colors.transparent, //Android top bar color
        statusBarIconBrightness: Brightness.light, //Android top bar icons
        systemNavigationBarColor:
            AppColors.greenColor, //Android bottom bar color
        systemNavigationBarIconBrightness:
            Brightness.light, //Android bottom bar icons
      );

  static const textStyleToolbarTitle = TextStyle(
    color: AppColors.textPrimaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: .5,
  );

  static const textStyleTitle = TextStyle(
    color: AppColors.textPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: .5,
  );

  static const textStyleMedium = TextStyle(
    color: AppColors.textPrimaryColor,
    fontSize: 14,
    letterSpacing: .5,
  );

  static const textStyleSmall = TextStyle(
    color: AppColors.textPrimaryColor,
    fontSize: 10,
    letterSpacing: .5,
  );

  static const textStyleInputType = TextStyle(
    letterSpacing: .5,
  );

  static const textStyleHint = TextStyle(
    color: AppColors.textHintColor,
    letterSpacing: .5,
  );

  static const questionBox = BoxDecoration(
    color: AppColors.blueColor,
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static const answerBox = BoxDecoration(
    color: AppColors.greenColorLight,
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static const bgGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        AppColors.orangeColor,
        AppColors.greenColor,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  );

  static const bgFlag = BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/bg.png"),
      fit: BoxFit.cover,
    ),
  );

  final bgLogo = BoxDecoration(
    image: DecorationImage(
      opacity: .2,
      scale: 3,
      image: Image.asset(
        "assets/images/app_logo.png",
      ).image,
    ),
  );
}
