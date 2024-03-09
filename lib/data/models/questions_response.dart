import 'package:pollstar/data/models/question.dart';

class QuestionsResponse {
  int? state;
  String? message;
  List<Question>? questions;

  QuestionsResponse({this.state, this.message, this.questions});

  QuestionsResponse.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    if (json['updates'] != null) {
      questions = <Question>[];
      json['updates'].forEach((v) {
        questions!.add(Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['message'] = message;
    if (questions != null) {
      data['updates'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
