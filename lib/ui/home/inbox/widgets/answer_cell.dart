import 'package:flutter/material.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class AnswerWidget extends StatelessWidget {
  final Question question;
  const AnswerWidget({super.key, required this.question});
  final hasAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32),
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
    return Container(
      //color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: (hasAnswer)
                ? AppColors.greenColorLight
                : AppColors.textColorDisabled,
            radius: radius,
            child: Icon(
              Icons.people_alt_outlined,
              color:
                  (hasAnswer) ? AppColors.greenColor : AppColors.textColorDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppUtils().getTimeFromDate(question.questionTime?.updated),
            style: AppStyle.textStyleMedium.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _answerWidget() {
    return Flexible(
      child: Container(
        decoration: AppStyle.answerBox.copyWith(
          color: (hasAnswer)
              ? AppColors.greenColorLight
              : AppColors.textColorDisabled,
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 16),
        child: Text(
          AppStrings.noResponseSent,
          style: AppStyle.textStyleMedium.copyWith(
            color: AppColors.textColorDark,
            fontSize: 16,
            fontWeight: (hasAnswer) ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
