part of 'outbox_bloc.dart';

sealed class OutboxEvent extends Equatable {
  const OutboxEvent();

  @override
  List<Object> get props => [];
}

class GetOutboxQuestions extends OutboxEvent {
  const GetOutboxQuestions();

  @override
  List<Object> get props => [];
}
