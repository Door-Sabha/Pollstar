import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/ui/home/inbox/bloc/inbox_bloc.dart';
import 'package:pollstar/ui/widgets/textfields.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';

import '../../utils/theme/styles.dart';
import 'buttons.dart';

class AnswerDialog extends StatelessWidget {
  final Question question;
  final QuestionType questionType;

  const AnswerDialog({
    super.key,
    required this.question,
    required this.questionType,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                question.text ?? "",
                style: AppStyle.textStyleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            (questionType == QuestionType.yesno)
                ? _yesnoWidget(context, question)
                : (questionType == QuestionType.number)
                    ? _numberWidget(context, question)
                    : Container(),
          ],
        ),
      ),
    );
  }

  Widget _yesnoWidget(BuildContext context, Question question) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MySquareIconButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<InboxBloc>().add(AnswerInboxQuestion(
                id: question.id?.toString() ?? "", answer: "2"));
          },
          icon: Icons.close_rounded,
          backgroundColor: AppColors.redColor,
        ),
        MySquareIconButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<InboxBloc>().add(AnswerInboxQuestion(
                  id: question.id?.toString() ?? "", answer: "1"));
            },
            icon: Icons.done_rounded),
      ],
    );
  }

  Widget _numberWidget(BuildContext context, Question question) {
    TextEditingController controller = TextEditingController();
    return Column(
      children: [
        TextField(
          controller: controller,
          maxLines: 1,
          buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) =>
              Container(),
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: AppStrings.answerHint,
          ),
        ),
        MySquareIconButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<InboxBloc>().add(AnswerInboxQuestion(
                  id: question.id?.toString() ?? "",
                  answer: controller.text.toString()));
            },
            icon: Icons.done_rounded),
      ],
    );
  }
}
