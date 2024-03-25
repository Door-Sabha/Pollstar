part of 'user_info_bloc.dart';

sealed class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends UserInfoEvent {
  const GetUserInfo();

  @override
  List<Object> get props => [];
}

class LogoutUser extends UserInfoEvent {
  const LogoutUser();

  @override
  List<Object> get props => [];
}

class UpdateFcmToken extends UserInfoEvent {
  const UpdateFcmToken();

  @override
  List<Object> get props => [];
}

class UpdateLocalAnswers extends UserInfoEvent {
  const UpdateLocalAnswers();

  @override
  List<Object> get props => [];
}
