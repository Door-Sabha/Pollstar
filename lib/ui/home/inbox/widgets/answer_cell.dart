import 'package:flutter/material.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/answer.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/utils/hive_manager.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class AnswerWidget extends StatelessWidget {
  final Question question;
  final HiveManager _hive;
  AnswerWidget({super.key, required this.question})
      : _hive = getIt<HiveManager>();

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
    bool hasAnswer = _hive.containsAnswer(question.sId);
    const double radius = 24;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: (hasAnswer)
              ? AppColors.greenColorLight
              : AppColors.textColorDisabled,
          radius: radius,
          child: Icon(
            Icons.people_alt_outlined,
            color: (hasAnswer) ? AppColors.greenColor : AppColors.textColorDark,
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
    );
  }

  Widget _answerWidget() {
    bool hasAnswer = _hive.containsAnswer(question.sId);
    Answer? answer = _hive.getAnswers(question.sId);
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
          (hasAnswer && answer != null)
              ? (question.questionType == QuestionType.yesno)
                  ? (answer.answer == "1" ? "YES" : "NO")
                  : answer.answer
              : AppStrings.noResponseSent,
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
