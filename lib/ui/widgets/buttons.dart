import 'package:flutter/material.dart';
import 'package:pollstar/utils/theme/colors.dart';

import '../../utils/theme/styles.dart';

class MyElevatedButton extends StatelessWidget {
  //final double _buttonHeight = 48.h;
  final String text;
  final bool isFullWidth;
  final Function onPressed;
  final Color? backgroundColor;
  final Color textColor;

  const MyElevatedButton({
    Key? key,
    this.text = "",
    this.isFullWidth = true,
    required this.onPressed,
    this.backgroundColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (isFullWidth) ? double.infinity : null,
      //height: _buttonHeight,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            letterSpacing: .5,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyTextButton extends StatelessWidget {
  //final double _buttonHeight = 48.0.h;
  final String text;
  final bool isFullWidth;
  final Function onPressed;
  final Color? backgroundColor;
  final Color textColor;

  const MyTextButton({
    Key? key,
    this.text = "",
    this.isFullWidth = true,
    required this.onPressed,
    this.backgroundColor,
    this.textColor = AppColors.themeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (isFullWidth) ? double.infinity : null,
      //height: _buttonHeight,
      child: TextButton(
          onPressed: () => onPressed(),
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: .5,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

class MyRoundIconButton extends StatelessWidget {
  const MyRoundIconButton({
    super.key,
    required this.title,
    required this.icon,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.iconColor,
    required this.onPressed,
  });
  final String title;
  final IconData icon;
  final Function onPressed;
  final Color? backgroundColor;
  final Color textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
            backgroundColor: backgroundColor,
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: AppStyle.textStyleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class MyOutlinedButton extends StatelessWidget {
  final String text;
  final bool isFullWidth;
  final Function onPressed;
  final Color textColor;
  final IconData? suffixIcon;
  final double buttonHeight;
  final double fontSize;
  final double? width;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const MyOutlinedButton({
    Key? key,
    this.text = "",
    this.isFullWidth = true,
    this.textColor = AppColors.textColorDark,
    this.suffixIcon,
    this.buttonHeight = 24,
    this.width,
    this.iconColor,
    this.fontSize = 11,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (isFullWidth) ? double.infinity : null,
      height: buttonHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1, color: borderColor ?? textColor),
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(5),
        ),
        onPressed: () => onPressed(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (suffixIcon != null) const SizedBox(width: 4),
            if (suffixIcon != null)
              Icon(
                suffixIcon,
                size: fontSize,
                color: textColor,
                // opticalSize: fontSize,
              ),
          ],
        ),
      ),
    );
  }
}

class LocalAuthButton extends StatelessWidget {
  final String text;
  final bool isFullWidth;
  final Function onPressed;
  final Color textColor;
  final Widget? icon;
  final double buttonHeight;
  final double fontSize;
  final double? width;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const LocalAuthButton({
    Key? key,
    this.text = "",
    this.isFullWidth = true,
    this.textColor = AppColors.textColorDark,
    this.icon,
    this.buttonHeight = 36,
    this.width,
    this.iconColor,
    this.fontSize = 16,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (isFullWidth) ? double.infinity : null,
      height: buttonHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1, color: borderColor ?? textColor),
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(5),
        ),
        onPressed: () => onPressed(),
        child: Stack(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: icon!,
              ),
            Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  //fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
