part of 'answer_confirmation_bloc.dart';

sealed class AnswerConfirmationState extends Equatable {
  const AnswerConfirmationState();

  @override
  List<Object> get props => [];
}

final class AnswerConfirmationInitial extends AnswerConfirmationState {}

final class YesNoQuestionState extends AnswerConfirmationState {
  final bool answer;

  const YesNoQuestionState({required this.answer});

  @override
  List<Object> get props => [answer];
}

final class NumberQuestionState extends AnswerConfirmationState {}

final class NumberQuestionConfirmationState extends AnswerConfirmationState {
  final String answer;

  const NumberQuestionConfirmationState({required this.answer});

  @override
  List<Object> get props => [answer];
}
