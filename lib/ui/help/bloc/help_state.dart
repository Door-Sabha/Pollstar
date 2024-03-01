part of 'help_bloc.dart';

sealed class HelpState extends Equatable {
  const HelpState();

  @override
  List<Object> get props => [];
}

final class HelpInitial extends HelpState {}

class HelpErrorState extends HelpState {
  final String error;

  const HelpErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class ProblemReportingLoading extends HelpState {}

final class ProblemReportingSuccess extends HelpState {
  final ApiResponse data;

  const ProblemReportingSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
