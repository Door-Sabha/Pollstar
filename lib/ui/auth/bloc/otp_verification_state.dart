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

class OtpResendSuccessState extends OtpVerificationState {
  final User user;
  const OtpResendSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class OtpVerificationSuccessState extends OtpVerificationState {
  const OtpVerificationSuccessState();

  @override
  List<Object> get props => [];
}
