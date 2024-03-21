part of 'questions_bloc.dart';

sealed class QuestionListEvent extends Equatable {
  const QuestionListEvent();

  @override
  List<Object> get props => [];
}

class GetQuestionsList extends QuestionListEvent {
  final bool isBackground;
  const GetQuestionsList({this.isBackground = false});

  @override
  List<Object> get props => [isBackground];
}

class OpenAnswerDialog extends QuestionListEvent {
  final Question question;
  final bool yesnoAnswer;
  const OpenAnswerDialog({required this.question, required this.yesnoAnswer});

  @override
  List<Object> get props => [question, yesnoAnswer];
}

class AnswerQuestion extends QuestionListEvent {
  final Question question;
  final String answer;
  const AnswerQuestion({required this.question, required this.answer});

  @override
  List<Object> get props => [question, answer];
}

class UpdateQuestionsQueued extends QuestionListEvent {
  final String id;
  const UpdateQuestionsQueued({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateQuestionsTriggered extends QuestionListEvent {
  final String id;
  const UpdateQuestionsTriggered({required this.id});

  @override
  List<Object> get props => [id];
}
