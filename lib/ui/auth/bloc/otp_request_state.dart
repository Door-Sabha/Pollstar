part of 'otp_request_bloc.dart';

sealed class OtpRequestState extends Equatable {
  const OtpRequestState();

  @override
  List<Object> get props => [];
}

final class OtpRequestInitialState extends OtpRequestState {}

class OtpRequestLoadingState extends OtpRequestState {}

class OtpRequestErrorState extends OtpRequestState {
  final String error;

  const OtpRequestErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class OtpRequestSuccessState extends OtpRequestState {
  final ApiResponse data;
  const OtpRequestSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}
