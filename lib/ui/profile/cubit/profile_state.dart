part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetUserLoading extends ProfileState {}

final class GetUserSuccess extends ProfileState {
  final LoginModel user;

  GetUserSuccess(this.user);
}

final class GetUserError extends ProfileState {
  final String errorMessage;

  GetUserError(this.errorMessage);
}

final class UpdateUserLoading extends ProfileState {}

final class UpdateUserSuccess extends ProfileState {
  final LoginModel updatedUser;

  UpdateUserSuccess(this.updatedUser);
}

final class UpdateUserError extends ProfileState {
  final String errorMessage;

  UpdateUserError(this.errorMessage);
}
