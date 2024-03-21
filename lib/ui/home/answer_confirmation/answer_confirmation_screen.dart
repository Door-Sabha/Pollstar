import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/ui/home/answer_confirmation/bloc/answer_confirmation_bloc.dart';
import 'package:pollstar/ui/home/bloc/questions_bloc.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/utils/extensions.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';
import 'package:sprintf/sprintf.dart';

class AnswerConfirmationScreen extends StatelessWidget {
  final Question question;
  final bool yesnoAnswer;
  const AnswerConfirmationScreen(
      {super.key, required this.question, this.yesnoAnswer = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnswerConfirmationBloc()
        ..add(
            LoadInitialQuestion(question: question, yesnoAnswer: yesnoAnswer)),
      child: Scaffold(
        body: Container(
          decoration: AppStyle.bgGradient,
          height: double.infinity,
          padding: EdgeInsets.only(
              left: 32, right: 32, top: MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _closeButton(context),
              _questionWidget(),
              _buildSubmitWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _closeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton.filled(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _questionWidget() {
    return Text(
      question.text ?? "",
      style: AppStyle.textStyleMedium.copyWith(
        color: Colors.white,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubmitWidget() {
    return BlocConsumer<AnswerConfirmationBloc, AnswerConfirmationState>(
      listener: (BuildContext context, AnswerConfirmationState state) {},
      builder: (context, state) {
        if (state is YesNoQuestionState) {
          return _yesnoConfirmationWidget(context);
        } else if (state is NumberQuestionState) {
          return _numberWidget(context);
        } else if (state is NumberQuestionConfirmationState) {
          return _numberConfirmationWidget(context, state.answer);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _yesnoConfirmationWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          child: Text(
            sprintf(AppStrings.yesnoMsg1, [(yesnoAnswer) ? "YES" : "NO"]),
            style: AppStyle.textStyleMedium.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        _submitButtonWidget(context, yesnoAnswer ? "1" : "2"),
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
            style: AppStyle.textStyleMedium.copyWith(
              color: Colors.white,
            ),
            maxLines: 1,
            buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    required maxLength}) =>
                Container(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: AppStrings.answerHint,
            ),
          ),
          const SizedBox(height: 32),
          MyElevatedButton(
            onPressed: () => _switchToNumberConfirmation(
                context, controller.text.trim().toString()),
            isFullWidth: false,
            text: AppStrings.done,
          ),
        ],
      ),
    );
  }

  _switchToNumberConfirmation(BuildContext context, String answer) {
    AppUtils().hideKeyboard();
    if (answer.isNullOrEmpty() || answer is! Int) {
      AppUtils().showAlertDialog(context, content: AppStrings.answerEmpty);
    } else {
      context
          .read<AnswerConfirmationBloc>()
          .add(SwitchForNumberConfirmation(answer: answer));
    }
  }

  Widget _numberConfirmationWidget(BuildContext context, String answer) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: AppStrings.numberMsg1,
              style: AppStyle.textStyleTitle.copyWith(
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: "\n$answer\n",
                  style: AppStyle.textStyleTitle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: AppStrings.numberMsg2,
                  style: AppStyle.textStyleTitle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
          Navigator.of(context).pop();
          context.read<QuestionListBloc>().add(
                AnswerQuestion(
                    question: question, answer: yesnoAnswer ? "1" : "2"),
              );
        },
        isFullWidth: false,
        text: AppStrings.answerSubmit,
      ),
    );
  }
}
