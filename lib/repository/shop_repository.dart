import 'package:salla/repository/models/categories_model.dart';
import 'package:salla/repository/models/change_favorites_model.dart';
import 'package:salla/repository/models/favorites_model.dart';
import 'package:salla/repository/models/home_model.dart';
import 'package:salla/repository/models/login_model.dart';
import 'package:salla/repository/models/product_details_model.dart';
import 'package:salla/repository/models/search_model.dart';
import 'package:salla/repository/services/shop_service.dart';

import 'models/categories_details_model.dart';

class ShopRepository {
  final ShopService shopService;

  ShopRepository({required this.shopService});

  Future<LoginModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async =>
      shopService.register(
          name: name, email: email, password: password, phone: phone);

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async =>
      shopService.login(email: email, password: password);

  Future<HomeModel> getHomeData() async => shopService.getHomeData();

  Future<ProductDetailsModel> getProductDetails({required int id}) async =>
      shopService.getProductDetails(id: id);

  Future<SearchModel> searchProducts({required String query}) async =>
      shopService.searchProducts(query: query);

  Future<CategoriesModel> getCategories() async => shopService.getCategories();

  Future<CategoryDetailsModel> getCategoryDetails({required int id}) async =>
      shopService.getCategoryDetails(id: id);

  Future<FavoritesModel> getFavorites(String token) async =>
      shopService.getFavorites(token);

  Future<ChangeFavoritesModel> changeFavorites(
          {required int productId, required String token}) async =>
      shopService.changeFavorites(productId: productId, token: token);

  Future<LoginModel> getUser(String token) async => shopService.getUser(token);

  Future<LoginModel> updateUserData(
          {required String name,
          required String email,
          required String phone,
          required String token}) async =>
      shopService.updateUserData(
          name: name, email: email, phone: phone, token: token);
}
