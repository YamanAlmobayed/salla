import 'package:flutter/material.dart';
import 'package:salla/repository/models/categories_details_model.dart';
import 'package:salla/repository/models/home_model.dart';
import 'package:salla/ui/widgets/grid_product.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, this.homeProducts, this.categoryProducts});

  final List<CategoryDetailsData>? categoryProducts;
  final List<ProductModel>? homeProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: GridView.count(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1 / 1.51,
        children: List.generate(
            categoryProducts == null
                ? homeProducts!.length
                : categoryProducts!.length,
            (index) => GridProduct(
                  model: categoryProducts == null
                      ? homeProducts![index]
                      : categoryProducts![index].product,
                )),
      ),
    );
  }
}
