import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/secure_storage_manager.dart';
import 'package:pollstar/utils/strings.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final PollStarRepository _repository;
  OtpVerificationBloc(this._repository) : super(OtpVerificationInitial()) {
    on<VerifyOtp>(_verifyOtp);
    on<UpdateCountdown>(_updateCountdown);
  }

  Future<void> _verifyOtp(VerifyOtp event, emit) async {
    String phone = event.phone.replaceAll("+91", "").trim();
    phone = phone.replaceAll(" ", "");
    if (phone.trim().length != 10) {
      emit(OtpVerificationInitial());
      emit(const OtpVerificationErrorState(
          error: AppStrings.errValidPhoneNumber));
      return;
    } else {
      emit(OtpVerificationLoadingState());
      ApiResponse? response =
          await _repository.verifyOtp(phone: phone, otp: event.otp);
      if (response != null && response.state == 1) {
        await getIt<SecureStorageManager>()
            .updateValue(AppStrings.prefSession, response.session);
        emit(OtpVerificationSuccessState(data: response));
      } else if (response != null && response.state == 0) {
        emit(OtpVerificationErrorState(
            error: response.message ?? AppStrings.errorApiUnknown));
      } else {
        emit(
            const OtpVerificationErrorState(error: AppStrings.errorApiUnknown));
      }
    }
  }

  Future<void> _updateCountdown(UpdateCountdown event, emit) async {
    emit(OtpVerificationInitial());
    emit(CountdownState());
  }
}
