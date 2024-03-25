import 'package:hive_flutter/hive_flutter.dart';

part 'answer.g.dart';

@HiveType(typeId: 0, adapterName: "AnswerAdapter")
class Answer extends HiveObject {
  @HiveField(0)
  String questionId;

  @HiveField(1)
  int updated;

  @HiveField(2)
  String answer;

  @HiveField(3)
  String userId;

  Answer(
      {required this.questionId,
      required this.updated,
      required this.answer,
      required this.userId});
}
