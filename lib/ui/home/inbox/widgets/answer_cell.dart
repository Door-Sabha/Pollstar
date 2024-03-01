import 'package:flutter/material.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _answerWidget(),
          _logoWidget(),
        ],
      ),
    );
  }

  Widget _logoWidget() {
    const double radius = 24;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.greenColorLight,
          radius: radius,
          child: Icon(Icons.people_alt_outlined),
        ),
        const SizedBox(height: 4),
        Text(
          "11:21 am",
          style: AppStyle.textStyleMedium.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _answerWidget() {
    return Flexible(
      child: Container(
        decoration: AppStyle.answerBox,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 16),
        child: Text(
          "255",
          style: AppStyle.textStyleMedium.copyWith(
            color: AppColors.textColorDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
