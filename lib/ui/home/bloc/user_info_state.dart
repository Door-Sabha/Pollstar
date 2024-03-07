part of 'user_info_bloc.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

final class UserInfoInitial extends UserInfoState {}

final class UserInfoLoading extends UserInfoState {}

final class UserInfoError extends UserInfoState {
  final String error;

  const UserInfoError({required this.error});

  @override
  List<Object> get props => [error];
}

final class UserInfoSuccess extends UserInfoState {
  final User user;

  const UserInfoSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class UserLogoutLoading extends UserInfoState {}

final class UserLogoutSuccess extends UserInfoState {}

final class UserFcmUpdateSuccess extends UserInfoState {}
