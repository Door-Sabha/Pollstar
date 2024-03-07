import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/ui/home/inbox/bloc/inbox_bloc.dart';
import 'package:pollstar/ui/home/inbox/widgets/answer_cell.dart';
import 'package:pollstar/ui/widgets/buttons.dart';
import 'package:pollstar/ui/widgets/images.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:pollstar/utils/utils.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final bool isInbox;
  const QuestionWidget(
      {super.key, required this.question, required this.isInbox});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logoWidget(),
              _questionWidget(),
            ],
          ),
          if (isInbox)
            if (question.questionType == QuestionType.yesno)
              _yesNoWidget(context, question)
            else if (question.questionType == QuestionType.number)
              _replyWidget(context, question)
            else
              Container()
          else
            AnswerWidget(question: question),
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
          backgroundColor: AppColors.textColorDisabled,
          radius: radius,
          child: MyImage(
            image: "app_logo",
            size: radius * 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppUtils().getTimeFromDate(question.questionTime?.trigger),
          style: AppStyle.textStyleMedium.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _questionWidget() {
    return Flexible(
      child: Container(
        decoration: AppStyle.questionBox,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            question.text ?? "",
            style: AppStyle.textStyleMedium.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _replyWidget(BuildContext context, Question question) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: MyElevatedIconButton(
        text: AppStrings.reply,
        icon: Icons.reply_rounded,
        onPressed: () => context.read<InboxBloc>().add(OpenAnswerDialog(
            question: question, questionType: QuestionType.number)),
      ),
    );
  }

  Widget _yesNoWidget(BuildContext context, Question question) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyElevatedButton(
            isFullWidth: false,
            text: AppStrings.yes,
            onPressed: () => context.read<InboxBloc>().add(OpenAnswerDialog(
                question: question, questionType: QuestionType.yesno)),
          ),
          const SizedBox(width: 16),
          MyElevatedButton(
            isFullWidth: false,
            text: AppStrings.no,
            backgroundColor: AppColors.redColor,
            onPressed: () => context.read<InboxBloc>().add(OpenAnswerDialog(
                question: question, questionType: QuestionType.yesno)),
          ),
        ],
      ),
    );
  }
}
