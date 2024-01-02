import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/repository/models/categories_model.dart';
import 'package:salla/repository/shop_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.shopRepository}) : super(CategoriesInitial());
  final ShopRepository shopRepository;

  void getCategories() async {
    emit(GetCategoryLoading());
    try {
      final categories = await shopRepository.getCategories();
      emit(GetCategorySuccess(categories));
    } catch (e) {
      emit(GetCategoryError(e.toString()));
    }
  }
}
