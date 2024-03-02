part of 'otp_verification_bloc.dart';

sealed class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object> get props => [];
}

final class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoadingState extends OtpVerificationState {}

class OtpVerificationErrorState extends OtpVerificationState {
  final String error;

  const OtpVerificationErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class OtpVerificationSuccessState extends OtpVerificationState {
  final ApiResponse data;
  const OtpVerificationSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}

class CountdownState extends OtpVerificationState {}
