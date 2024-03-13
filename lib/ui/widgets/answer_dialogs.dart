import 'package:flutter/material.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/utils/extensions.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/utils.dart';

import '../../utils/theme/styles.dart';
import 'buttons.dart';

class AnswerDialog extends StatelessWidget {
  final Question question;
  final bool yesnoAnswer;

  const AnswerDialog({
    super.key,
    required this.question,
    required this.yesnoAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _questionWidget(),
            (question.questionType == QuestionType.yesno)
                ? _yesnoConfirmationWidget(context)
                : (question.questionType == QuestionType.number)
                    ? _numberWidget(context)
                    : Container(),
          ],
        ),
      ),
    );
  }

  Widget _questionWidget() {
    return Text(
      question.text ?? "",
      style: AppStyle.textStyleMedium.copyWith(
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _yesnoConfirmationWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: AppStrings.yesnoMsg1,
              style: AppStyle.textStyleMedium.copyWith(
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: "\n${(yesnoAnswer) ? "YES" : "NO"}\n",
                  style: AppStyle.textStyleTitle.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    color: (yesnoAnswer)
                        ? AppColors.greenColor
                        : AppColors.redColor,
                  ),
                ),
                TextSpan(
                  text: AppStrings.yesnoMsg2,
                  style: AppStyle.textStyleMedium.copyWith(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        _submitButtonWidget(context),
      ],
    );
  }

  Widget _numberWidget(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            style: AppStyle.textStyleMedium.copyWith(),
            maxLines: 1,
            buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    required maxLength}) =>
                Container(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: AppStrings.answerHint,
            ),
          ),
          const SizedBox(height: 32),
          MyElevatedButton(
            onPressed: () {
              String ans = controller.text.toString();
              AppUtils().hideKeyboard();
              if (ans.isNullOrEmpty()) {
                Navigator.pop(context);
                AppUtils()
                    .showAlertDialog(context, content: AppStrings.answerEmpty);
              } else {
                Navigator.pop(context, ans);
              }
            },
            isFullWidth: false,
            text: AppStrings.submit,
          ),
        ],
      ),
    );
  }

  Widget _submitButtonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: MyElevatedButton(
        onPressed: () {
          Navigator.pop(context, yesnoAnswer);
        },
        isFullWidth: false,
        text: AppStrings.answerSubmit,
      ),
    );
  }
}

class AnswerConfirmationDialog extends StatelessWidget {
  final Question question;
  final String answer;

  const AnswerConfirmationDialog({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _numberConfirmationWidget(context, answer),
          ],
        ),
      ),
    );
  }

  Widget _numberConfirmationWidget(BuildContext context, String answer) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: AppStrings.numberMsg1,
              style: AppStyle.textStyleMedium.copyWith(
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: "\n$answer\n",
                  style: AppStyle.textStyleTitle.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      color: AppColors.greenColor),
                ),
                TextSpan(
                  text: AppStrings.numberMsg2,
                  style: AppStyle.textStyleMedium.copyWith(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        _submitButtonWidget(context, answer),
      ],
    );
  }

  Widget _submitButtonWidget(BuildContext context, String answer) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: MyElevatedButton(
        onPressed: () {
          Navigator.pop(context, answer);
        },
        isFullWidth: false,
        text: AppStrings.answerSubmit,
      ),
    );
  }
}
