part of 'inbox_bloc.dart';

sealed class InboxState extends Equatable {
  const InboxState();

  @override
  List<Object> get props => [];
}

final class InboxInitial extends InboxState {}

final class InboxLoading extends InboxState {
  final bool isDialog;

  const InboxLoading({this.isDialog = false});

  @override
  List<Object> get props => [isDialog];
}

final class InboxEmpty extends InboxState {}

class InboxErrorState extends InboxState {
  final String error;

  const InboxErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class InboxSuccessState extends InboxState {
  final List<Question> list;

  const InboxSuccessState({required this.list});

  @override
  List<Object> get props => [list];
}

class AnswerScreenState extends InboxState {
  final Question question;
  final bool yesnoAnswer;

  const AnswerScreenState({required this.question, required this.yesnoAnswer});

  @override
  List<Object> get props => [question, yesnoAnswer];
}

class InboxAnswerSuccessState extends InboxState {
  const InboxAnswerSuccessState();

  @override
  List<Object> get props => [];
}
