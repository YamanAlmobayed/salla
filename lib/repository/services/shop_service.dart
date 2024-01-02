import 'package:dio/dio.dart';
import 'package:salla/repository/models/categories_details_model.dart';
import 'package:salla/repository/models/change_favorites_model.dart';
import 'package:salla/repository/models/favorites_model.dart';
import 'package:salla/repository/models/home_model.dart';
import 'package:salla/repository/models/login_model.dart';
import 'package:salla/repository/models/product_details_model.dart';
import 'package:salla/repository/models/search_model.dart';
import 'package:salla/utils/api_urls.dart';

import '../models/categories_model.dart';

class ShopService {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://student.valuxapps.com/api/',
    headers: {'lang': 'en'},
  ));

  Future<LoginModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final body = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };
      final response = await _dio.post(APIUrls().register, data: body);
      return LoginModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error registering');
    }
  }

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };
      final response = await _dio.post(APIUrls().login, data: body);
      return LoginModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error login');
    }
  }

  Future<HomeModel> getHomeData() async {
    try {
      final response = await _dio.get(APIUrls().home);
      return HomeModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error getting home data');
    }
  }

  Future<ProductDetailsModel> getProductDetails({required int id}) async {
    try {
      final response = await _dio.get('${APIUrls().productDetails}/$id');
      return ProductDetailsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error getting product details');
    }
  }

  Future<SearchModel> searchProducts({required String query}) async {
    try {
      final body = {
        'text': query,
      };
      final response = await _dio.post(APIUrls().search, data: body);
      return SearchModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error searching for product');
    }
  }

  Future<CategoriesModel> getCategories() async {
    try {
      final response = await _dio.get(APIUrls().categories);
      return CategoriesModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error getting categories');
    }
  }

  Future<CategoryDetailsModel> getCategoryDetails({required int id}) async {
    try {
      final response = await _dio.get('${APIUrls().categories}/$id');
      return CategoryDetailsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error getting categories details');
    }
  }

  Future<FavoritesModel> getFavorites(String token) async {
    try {
      _dio.options.headers = {'Authorization': token, 'lang': 'en'};
      final response = await _dio.get(APIUrls().favorites);
      return FavoritesModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error getting favorites');
    }
  }

  Future<ChangeFavoritesModel> changeFavorites(
      {required int productId, required String token}) async {
    try {
      _dio.options.headers = {'Authorization': token, 'lang': 'en'};
      final body = {'product_id': productId};
      final response = await _dio.post(APIUrls().favorites, data: body);
      return ChangeFavoritesModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error changing favorites');
    }
  }

  Future<LoginModel> getUser(String token) async {
    try {
      _dio.options.headers = {'Authorization': token, 'lang': 'en'};
      final response = await _dio.get(APIUrls().profile);
      return LoginModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error getting user data');
    }
  }

  Future<LoginModel> updateUserData({
    required String name,
    required String email,
    required String phone,
    required String token,
  }) async {
    try {
      _dio.options.headers = {'Authorization': token, 'lang': 'en'};
      final body = {
        'name': name,
        'email': email,
        'phone': phone,
      };
      final response = await _dio.put(APIUrls().update, data: body);
      return LoginModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error updating user data');
    }
  }
}
