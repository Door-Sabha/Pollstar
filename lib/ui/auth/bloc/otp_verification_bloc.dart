import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/strings.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final PollStarRepository _repository;
  OtpVerificationBloc(this._repository) : super(OtpVerificationInitial()) {
    on<ResendOtp>(_resendOtp);
    on<VerifyOtp>(_verifyOtp);
    on<StartCountdown>(_startCountdown);
  }

  Future<void> _resendOtp(ResendOtp event, emit) async {
    if (event.phone.trim().length < 10) {
      emit(OtpVerificationInitial());
      emit(const OtpVerificationErrorState(
          error: "Enter a valid mobile number."));
    } else {
      emit(OtpVerificationLoadingState());
      User? user = await _repository.requestOtp(phone: event.phone);
      if (user != null && user.state == 1) {
        emit(OtpResendSuccessState(user: user));
      } else if (user != null && user.state == 0) {
        emit(OtpVerificationInitial());
        emit(OtpVerificationErrorState(
            error: user.message ?? AppStrings.errorApiUnknown));
      } else {
        emit(
            const OtpVerificationErrorState(error: AppStrings.errorApiUnknown));
      }
    }
  }

  Future<void> _verifyOtp(VerifyOtp event, emit) async {
    if (event.phone.trim().length != 10) {
      emit(OtpVerificationInitial());
      emit(const OtpVerificationErrorState(
          error: "Enter a valid mobile number."));
      return;
    } else {
      emit(OtpVerificationLoadingState());
      ApiResponse? response =
          await _repository.verifyOtp(phone: event.phone, otp: event.otp);
      if (response != null && response.state == 1) {
        emit(const OtpVerificationSuccessState());
      } else if (response != null && response.state == 0) {
        emit(OtpVerificationInitial());
        emit(OtpVerificationErrorState(
            error: response.message ?? AppStrings.errorApiUnknown));
      } else {
        emit(
            const OtpVerificationErrorState(error: AppStrings.errorApiUnknown));
      }
    }
  }

  Future<void> _startCountdown(StartCountdown event, emit) async {}
}
