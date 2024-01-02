import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/repository/models/product_details_model.dart';
import 'package:salla/repository/shop_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required this.shopRepository})
      : super(ProductDetailsInitial());

  final ShopRepository shopRepository;

  void getProductDetails(int id) async {
    emit(GetProductDetailsLoading());
    try {
      final productDetails = await shopRepository.getProductDetails(id: id);
      if (productDetails.status!) {
        emit(GetProductDetailsSuccess(productDetails));
      } else {
        emit(GetProductDetailsError(productDetails.message!));
      }
    } catch (e) {
      emit(GetProductDetailsError(e.toString()));
    }
  }
}
