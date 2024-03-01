part of 'help_bloc.dart';

sealed class HelpEvent extends Equatable {
  const HelpEvent();

  @override
  List<Object> get props => [];
}

class ReportProblem extends HelpEvent {
  final String type;
  final String message;
  const ReportProblem({required this.type, required this.message});

  @override
  List<Object> get props => [type, message];
}
