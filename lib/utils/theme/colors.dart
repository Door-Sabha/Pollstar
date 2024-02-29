import 'package:flutter/material.dart';

class AppColors {
  /// Light Theme Colors
  static const themePrimaryLightColor = Color(0xFFbfeb91);
  static const themeSecondaryLightColor = "";
  static const themeAscentLightColor = "";

  /// Dark Theme Colors
  static const themePrimaryDarkColor = "";
  static const themeSecondaryDarkColor = "";
  static const themeAscentDarkColor = "";

  //static const themeColor = Color(0xFF0D4C92);
  static const themeColor = greenColor;
  static primaryColor(BuildContext context) => themeColor;

  // Background Color
  static const scaffoldBackgroundColor = Colors.white;
  static const backgroundLight = Colors.white;
  static const backgroundDark = themeColor;

  static const toolbarForegroundColor = Colors.white;
  static const inputBackgroundColor = Colors.white;

  // Text Color
  //static textPrimaryColor() => textColorDark;
  static const textPrimaryColor = textColorDark;
  static const textColorDark = Colors.black;
  static const textColorLight = Colors.white;
  static const textColorDisabled = Color(0xFFACACAC);
  static const textHintColor = Color(0xFFACACAC);

  //Others
  static const orangeColor = Color(0xFFF09240);
  static const greenColor = Color(0xFF3F8627);
  static const redColor = Color(0xFFCB444A);
  static const blueColor = Color(0xFF000082);
  static const shadowColor = Color(0xFF9E9E9E);
}
