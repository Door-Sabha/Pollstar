part of 'otp_request_bloc.dart';

sealed class OtpRequestEvent extends Equatable {
  const OtpRequestEvent();

  @override
  List<Object> get props => [];
}

class RequestOtp extends OtpRequestEvent {
  final String phone;
  const RequestOtp({required this.phone});

  @override
  List<Object> get props => [phone];
}
