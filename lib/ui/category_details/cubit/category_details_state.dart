part of 'category_details_cubit.dart';

@immutable
sealed class CategoryDetailsState {}

final class CategoryDetailsInitial extends CategoryDetailsState {}

final class GetCategoryDetailsLoading extends CategoryDetailsState {}

final class GetCategoryDetailsSuccess extends CategoryDetailsState {
  final CategoryDetailsModel categoryDetails;

  GetCategoryDetailsSuccess(this.categoryDetails);
}

final class GetCategoryDetailsError extends CategoryDetailsState {
  final String errorMessage;

  GetCategoryDetailsError(this.errorMessage);
}
