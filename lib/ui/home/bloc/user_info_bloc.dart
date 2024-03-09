import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/strings.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final PollStarRepository _repository;
  UserInfoBloc(this._repository) : super(UserInfoInitial()) {
    on<GetUserInfo>(_getUserInfo);
    on<LogoutUser>(_logout);
    on<UpdateFcmToken>(_updateFcmToken);
  }

  Future<void> _getUserInfo(GetUserInfo event, emit) async {
    String session = getIt<AppConstants>().session;

    if (session.trim().isEmpty) {
      emit(UserInfoInitial());
      emit(const UserInfoError(error: "Enter a valid mobile number."));
    } else {
      emit(UserInfoLoading());

      User? data = await _repository.getUserInfo(session: session);
      if (data != null && data.state == 1) {
        getIt<AppConstants>().userId = data.id;
        getIt<AppConstants>().stateId = data.stateId;
        emit(UserInfoSuccess(user: data));
      } else if (data != null && data.state == 0) {
        emit(UserInfoInitial());
        emit(UserInfoError(error: data.message ?? AppStrings.errorApiUnknown));
      } else {
        emit(const UserInfoError(error: AppStrings.errorApiUnknown));
      }
    }
  }

  Future<void> _logout(LogoutUser event, emit) async {
    String userId = getIt<AppConstants>().userId;

    emit(UserLogoutLoading());

    ApiResponse? data = await _repository.logoutUser(id: userId);
    if (data != null && data.state == 1) {
      emit(UserLogoutSuccess());
    } else if (data != null && data.state == 0) {
      emit(UserInfoInitial());
      emit(UserInfoError(error: data.message ?? AppStrings.errorApiUnknown));
    } else {
      emit(const UserInfoError(error: AppStrings.errorApiUnknown));
    }
  }

  Future<void> _updateFcmToken(UpdateFcmToken event, emit) async {
    final fcmToken = getIt<AppConstants>().fcmToken;
    String userId = getIt<AppConstants>().userId;

    ApiResponse? data =
        await _repository.updateFcmToken(id: userId, token: fcmToken ?? "");
    if (data != null && data.state == 1) {
      emit(UserFcmUpdateSuccess());
    }
  }
}
