part of 'otp_verification_bloc.dart';

sealed class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtp extends OtpVerificationEvent {
  final String phone;
  final String otp;
  const VerifyOtp({required this.phone, required this.otp});

  @override
  List<Object> get props => [phone, otp];
}

class ResendOtp extends OtpVerificationEvent {
  final String phone;
  const ResendOtp({required this.phone});

  @override
  List<Object> get props => [phone];
}

class StartCountdown extends OtpVerificationEvent {
  const StartCountdown();

  @override
  List<Object> get props => [];
}