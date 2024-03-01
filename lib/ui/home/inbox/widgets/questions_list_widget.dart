import 'package:flutter/material.dart';
import 'package:pollstar/ui/home/inbox/widgets/answer_cell.dart';
import 'package:pollstar/ui/home/inbox/widgets/question_cell.dart';

class QuestionsListWidget extends StatelessWidget {
  const QuestionsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        QuestionWidget(),
        AnswerWidget(),
      ],
    );
  }
}
