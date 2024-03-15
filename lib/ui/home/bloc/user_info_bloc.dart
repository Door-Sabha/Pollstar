import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/connectivity_manager.dart';
import 'package:pollstar/utils/hive_manager.dart';
import 'package:pollstar/utils/secure_storage_manager.dart';
import 'package:pollstar/utils/strings.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final PollStarRepository _repository;
  final HiveManager _hive;
  UserInfoBloc(this._repository)
      : _hive = getIt<HiveManager>(),
        super(UserInfoInitial()) {
    on<GetUserInfo>(_getUserInfo);
    on<LogoutUser>(_logout);
    on<UpdateFcmToken>(_updateFcmToken);
  }

  Future<void> _getUserInfo(GetUserInfo event, emit) async {
    bool isOnline = await getIt<ConnectivityManager>().hasInternet();
    if (!isOnline) {
      emit(UserInfoInitial());
      emit(const UserInfoError(error: AppStrings.errorNetwork));
      return;
    }

    String session =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefSession) ??
            "";

    if (session.trim().isEmpty) {
      emit(UserInfoInitial());
      emit(const UserInfoError(error: AppStrings.errValidPhoneNumber));
    } else {
      emit(UserInfoLoading());

      User? data = await _repository.getUserInfo(session: session);

      if (data != null && data.state == 1) {
        await getIt<SecureStorageManager>()
            .updateValue(AppStrings.prefUserId, data.id);
        await getIt<SecureStorageManager>()
            .updateValue(AppStrings.prefStateId, data.stateId);

        _hive.updateUser(data);
        emit(UserInfoSuccess(user: data));
      } else if (data != null && data.state == 0) {
        emit(UserInfoError(error: data.message ?? AppStrings.errorApiUnknown));
      } else {
        emit(const UserInfoError(error: AppStrings.errorApiUnknown));
      }
    }
  }

  Future<void> _logout(LogoutUser event, emit) async {
    emit(UserLogoutLoading());
    String userId =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefUserId) ??
            "";

    ApiResponse? data = await _repository.logoutUser(id: userId);
    // if (data != null && data.state == 1) {
    //   emit(UserLogoutSuccess());
    // } else if (data != null && data.state == 0) {
    //   emit(UserInfoInitial());
    //   emit(UserInfoError(error: data.message ?? AppStrings.errorApiUnknown));
    // } else {
    //   emit(const UserInfoError(error: AppStrings.errorApiUnknown));
    // }
    emit(UserLogoutSuccess());
  }

  Future<void> _updateFcmToken(UpdateFcmToken event, emit) async {
    bool isOnline = await getIt<ConnectivityManager>().hasInternet();
    if (!isOnline) {
      return;
    }
    final fcmToken = await FirebaseMessaging.instance.getToken();
    String userId =
        await getIt<SecureStorageManager>().getValue(AppStrings.prefUserId) ??
            "";
    if (fcmToken == null || userId.isEmpty) return;

    ApiResponse? data =
        await _repository.updateFcmToken(id: userId, token: fcmToken ?? "");
    if (data != null && data.state == 1) {
      emit(UserFcmUpdateSuccess());
    }
  }
}
