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

class OpenAnswerScreen extends InboxEvent {
  final Question question;
  final bool yesnoAnswer;
  const OpenAnswerScreen({required this.question, required this.yesnoAnswer});

  @override
  List<Object> get props => [question, yesnoAnswer];
}

class AnswerInboxQuestion extends InboxEvent {
  final String id;
  final String answer;
  const AnswerInboxQuestion({required this.id, required this.answer});

  @override
  List<Object> get props => [id, answer];
}
