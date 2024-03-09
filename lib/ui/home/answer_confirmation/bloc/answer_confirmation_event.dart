part of 'answer_confirmation_bloc.dart';

sealed class AnswerConfirmationEvent extends Equatable {
  const AnswerConfirmationEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialQuestion extends AnswerConfirmationEvent {
  final Question question;
  final bool yesnoAnswer;
  const LoadInitialQuestion({required this.question, this.yesnoAnswer = false});

  @override
  List<Object> get props => [question, yesnoAnswer];
}

class SwitchForYesNoQuestion extends AnswerConfirmationEvent {
  const SwitchForYesNoQuestion();

  @override
  List<Object> get props => [];
}

class SwitchForNumberQuestion extends AnswerConfirmationEvent {
  const SwitchForNumberQuestion();

  @override
  List<Object> get props => [];
}

class SwitchForNumberConfirmation extends AnswerConfirmationEvent {
  final String answer;
  const SwitchForNumberConfirmation({required this.answer});

  @override
  List<Object> get props => [answer];
}
