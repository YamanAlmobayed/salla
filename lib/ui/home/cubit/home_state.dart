part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetHomeLoading extends HomeState {}

final class GetHomeSuccess extends HomeState {
  final HomeModel homeData;

  GetHomeSuccess(this.homeData);
}

final class GetHomeError extends HomeState {
  final String errorMessage;

  GetHomeError(this.errorMessage);
}
