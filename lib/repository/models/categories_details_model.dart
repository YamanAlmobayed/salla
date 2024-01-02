class CategoryDetailsModel {
  bool? status;
  String? message;
  Data? data;

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CategoryDetailsData>? data;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryDetailsData>[];
      json['data'].forEach((v) {
        data!.add(CategoryDetailsData.fromJson(v));
      });
    }
  }
}

class CategoryDetailsData {
  int? id;
  Product? product;

  CategoryDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json);
  }
}

class Product {
  int? id;
  num? price;
  num? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  // bool? inFavorites;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
