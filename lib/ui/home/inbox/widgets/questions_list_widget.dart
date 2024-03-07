import 'package:flutter/material.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/ui/home/inbox/widgets/question_cell.dart';

class QuestionsListWidget extends StatelessWidget {
  final List<Question> list;
  final bool isInbox;
  const QuestionsListWidget(
      {super.key, required this.list, this.isInbox = true});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) =>
          QuestionWidget(question: list[index], isInbox: isInbox),
    );
  }
}
