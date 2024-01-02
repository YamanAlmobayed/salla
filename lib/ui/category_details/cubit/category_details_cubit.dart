import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/repository/models/categories_details_model.dart';
import 'package:salla/repository/shop_repository.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit({required this.shopRepository})
      : super(CategoryDetailsInitial());

  final ShopRepository shopRepository;

  void getCategoryDetails(int id) async {
    emit(GetCategoryDetailsLoading());
    try {
      final categoryDetails = await shopRepository.getCategoryDetails(id: id);
      if (categoryDetails.status!) {
        emit(GetCategoryDetailsSuccess(categoryDetails));
      } else {
        emit(GetCategoryDetailsError(categoryDetails.message!));
      }
    } catch (e) {
      emit(GetCategoryDetailsError(e.toString()));
    }
  }
}
