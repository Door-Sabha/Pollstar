import 'package:flutter/material.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

class MyUnderlineText extends StatelessWidget {
  final double space;
  final Color underlineColor;
  final TextStyle style;
  final String text;

  const MyUnderlineText({
    super.key,
    required this.text,
    this.space = 0,
    this.underlineColor = AppColors.themeColor,
    this.style = AppStyle.textStyleMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: space,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: underlineColor,
            width: 2.0,
          ),
        ),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
