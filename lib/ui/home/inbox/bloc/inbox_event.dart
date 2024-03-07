part of 'inbox_bloc.dart';

sealed class InboxEvent extends Equatable {
  const InboxEvent();

  @override
  List<Object> get props => [];
}

class GetInboxQuestions extends InboxEvent {
  const GetInboxQuestions();

  @override
  List<Object> get props => [];
}

class OpenAnswerDialog extends InboxEvent {
  final Question question;
  final QuestionType questionType;
  const OpenAnswerDialog({required this.question, required this.questionType});

  @override
  List<Object> get props => [question, questionType];
}

class AnswerInboxQuestion extends InboxEvent {
  final String id;
  final String answer;
  const AnswerInboxQuestion({required this.id, required this.answer});

  @override
  List<Object> get props => [id, answer];
}
