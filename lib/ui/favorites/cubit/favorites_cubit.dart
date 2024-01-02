import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/repository/models/favorites_model.dart';
import 'package:salla/repository/shop_repository.dart';
import 'package:salla/utils/utils.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.shopRepository}) : super(FavoritesInitial());

  final ShopRepository shopRepository;

  List<Product> favoriteLocally = [];

  void getFavorite(String? token) async {
    if (token == null) return;
    emit(GetFavoritesLoading());
    try {
      final favorites = await shopRepository.getFavorites(token);
      if (favorites.data?.data != null) {
        favoriteLocally = [
          ...favorites.data!.data!.map((e) => e.product!).toList()
          // ...favorites.data!.data!.map((e) => e.product!.id!).toList()
        ];
      }
      emit(GetFavoritesSuccess(favorites));
    } catch (e) {
      emit(GetFavoritesError(e.toString()));
    }
  }

  void changeFavorite({required Product product, required String token}) async {
    try {
      if (favoriteLocally.contains(product)) {
        favoriteLocally.remove(product);
      } else {
        favoriteLocally.add(product);
      }

      emit(ChangeFavoriteLocallySuccess());
      final changeFavorite = await shopRepository.changeFavorites(
          productId: product.id!, token: token);
      if (!changeFavorite.status!) {
        showToast(text: changeFavorite.message!, state: ToastStates.error);
        getFavorite(token);
      }
    } catch (e) {
      showToast(text: e.toString(), state: ToastStates.error);
    }
  }
}
