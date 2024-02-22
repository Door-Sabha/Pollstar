import 'package:flutter/material.dart';

import 'colors.dart';

class AppStyle {
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

  static const textStylePasscodeInputType = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const textStyleHint = TextStyle(
    color: AppColors.textHintColor,
    letterSpacing: .5,
  );

  static const textStyleCard3D = TextStyle(
    color: Colors.white,
    letterSpacing: 5,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(0, 2),
        blurRadius: 15.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ],
  );

  static const textStyleCard2D = TextStyle(
    color: Colors.white,
    letterSpacing: 5,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static final inputboxBackground = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 20,
        offset: Offset(0, 10),
      ),
    ],
  );

  static final inputBorderBottomOnly = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.grey.shade200,
      ),
    ),
  );

  static const bgRoundCornerWhite = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const bgCard = BoxDecoration(
    color: AppColors.scaffoldBackgroundColor,
    borderRadius: BorderRadius.all(Radius.circular(32)),
  );

  static const bgCardWithShadow = BoxDecoration(
    color: AppColors.scaffoldBackgroundColor,
    borderRadius: BorderRadius.all(Radius.circular(32)),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const bgCard16 = BoxDecoration(
    color: AppColors.scaffoldBackgroundColor,
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static const bgCard8 = BoxDecoration(
    color: AppColors.scaffoldBackgroundColor,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static final toolbarIconBorder = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    border: Border.all(color: Colors.white54),
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

  static const bgCardOnlyTop = BoxDecoration(
    color: AppColors.scaffoldBackgroundColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(32),
      topRight: Radius.circular(32),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const bgCardOnlyBottom = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(32),
      bottomRight: Radius.circular(32),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 0),
      ),
    ],
  );

  static EdgeInsets bottomCardPadding =
      const EdgeInsets.symmetric(vertical: 16, horizontal: 32);
  static TextStyle bottomCardTitle = AppStyle.textStyleToolbarTitle;
  static TextStyle bottomCardSubTitle = AppStyle.textStyleMedium.copyWith(
    color: AppColors.textColorDisabled,
    letterSpacing: .25,
  );

  static const incomingTransactionGradient = BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(34, 139, 34, .2),
      Color.fromRGBO(34, 139, 34, .8),
    ],
  ));

  static const outgoingTransactionGradient = BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromRGBO(178, 34, 34, .2),
      Color.fromRGBO(178, 34, 34, .8),
    ],
  ));
}
