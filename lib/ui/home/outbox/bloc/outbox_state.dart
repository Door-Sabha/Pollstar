part of 'outbox_bloc.dart';

sealed class OutboxState extends Equatable {
  const OutboxState();

  @override
  List<Object> get props => [];
}

final class OutboxInitial extends OutboxState {}

final class OutboxLoading extends OutboxState {}

final class OutboxEmpty extends OutboxState {}

class OutboxErrorState extends OutboxState {
  final String error;

  const OutboxErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class OutboxSuccessState extends OutboxState {
  final List<Question> list;

  const OutboxSuccessState({required this.list});

  @override
  List<Object> get props => [list];
}
