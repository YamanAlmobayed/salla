import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla/repository/models/categories_model.dart';

import 'home_category_item.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.categories});

  final List<DataModel> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: 40.0.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 10.w,
          ),
          SizedBox(
            height: 200.w,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => HomeCategoryItem(
                      model: categories[index],
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      width: 10.w,
                    ),
                itemCount: categories.length),
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            'Products',
            style: TextStyle(fontSize: 40.0.sp, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
