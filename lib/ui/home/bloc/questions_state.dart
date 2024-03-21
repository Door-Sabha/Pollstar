part of 'questions_bloc.dart';

sealed class QuestionListState extends Equatable {
  const QuestionListState();

  @override
  List<Object> get props => [];
}

final class QuestionListInitial extends QuestionListState {}

final class QuestionListLoading extends QuestionListState {
  final bool isDialog;

  const QuestionListLoading({this.isDialog = false});

  @override
  List<Object> get props => [isDialog];
}

final class AnswerLoading extends QuestionListState {
  const AnswerLoading();

  @override
  List<Object> get props => [];
}

final class InboxListEmpty extends QuestionListState {}

final class OutboxListEmpty extends QuestionListState {}

class QuestionListErrorState extends QuestionListState {
  final String error;

  const QuestionListErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class NoNetworkState extends QuestionListState {
  final String error;

  const NoNetworkState({required this.error});

  @override
  List<Object> get props => [error];
}

class InboxListSuccessState extends QuestionListState {
  final List<Question> list;

  const InboxListSuccessState({required this.list});

  @override
  List<Object> get props => [list];
}

class OutboxListSuccessState extends QuestionListState {
  final List<Question> list;

  const OutboxListSuccessState({required this.list});

  @override
  List<Object> get props => [list];
}

final class SessionEndState extends QuestionListState {}

class AnswerScreenState extends QuestionListState {
  final Question question;
  final bool yesnoAnswer;

  const AnswerScreenState({required this.question, required this.yesnoAnswer});

  @override
  List<Object> get props => [question, yesnoAnswer];
}

class AnswerSuccessState extends QuestionListState {
  const AnswerSuccessState();

  @override
  List<Object> get props => [];
}

class UpdatedQuestionsQueued extends QuestionListState {
  const UpdatedQuestionsQueued();

  @override
  List<Object> get props => [];
}

class UpdatedQuestionsTriggered extends QuestionListState {
  const UpdatedQuestionsTriggered();

  @override
  List<Object> get props => [];
}
