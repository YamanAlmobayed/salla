part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final LoginModel user;

  RegisterSuccess(this.user);
}

final class RegisterError extends RegisterState {
  final String errorMessage;

  RegisterError(this.errorMessage);
}

final class TogglePasswordVisibility extends RegisterState {}
