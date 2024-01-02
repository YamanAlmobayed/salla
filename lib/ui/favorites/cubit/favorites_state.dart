part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class GetFavoritesLoading extends FavoritesState {}

final class GetFavoritesSuccess extends FavoritesState {
  final FavoritesModel favorites;

  GetFavoritesSuccess(this.favorites);
}

final class GetFavoritesError extends FavoritesState {
  final String errorMessage;

  GetFavoritesError(this.errorMessage);
}

final class ChangeFavoriteLocallySuccess extends FavoritesState {}
