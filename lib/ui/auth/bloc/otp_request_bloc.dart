import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/network/api/pollstar_api.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/strings.dart';

part 'otp_request_event.dart';
part 'otp_request_state.dart';

class OtpRequestBloc extends Bloc<OtpRequestEvent, OtpRequestState> {
  final PollStarRepository _repository;
  OtpRequestBloc(this._repository) : super(OtpRequestInitialState()) {
    on<RequestOtp>(_requestOtp);
  }

  Future<void> _requestOtp(RequestOtp event, emit) async {
    if (event.phone.trim().length < 10) {
      emit(OtpRequestInitialState());
      emit(const OtpRequestErrorState(error: "Enter a valid mobile number."));
    } else {
      emit(OtpRequestLoadingState());
      User? user = await _repository.requestOtp(phone: event.phone);
      if (user != null && user.state == 1) {
        emit(OtpRequestSuccessState(user: user));
      } else if (user != null && user.state == 0) {
        emit(OtpRequestInitialState());
        emit(OtpRequestErrorState(
            error: user.message ?? AppStrings.errorApiUnknown));
      } else {
        emit(const OtpRequestErrorState(error: AppStrings.errorApiUnknown));
      }
    }
  }
}
