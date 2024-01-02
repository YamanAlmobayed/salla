part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class GetCategoryLoading extends CategoriesState {}

final class GetCategorySuccess extends CategoriesState {
  final CategoriesModel categories;

  GetCategorySuccess(this.categories);
}

final class GetCategoryError extends CategoriesState {
  final String errorMessage;

  GetCategoryError(this.errorMessage);
}
