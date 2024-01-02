part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class GetProductDetailsLoading extends ProductDetailsState {}

final class GetProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsModel productDetails;

  GetProductDetailsSuccess(this.productDetails);
}

final class GetProductDetailsError extends ProductDetailsState {
  final String errorMessage;

  GetProductDetailsError(this.errorMessage);
}
