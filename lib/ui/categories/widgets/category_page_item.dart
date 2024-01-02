import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/utils/router/routes.dart';

import '../../../repository/models/categories_model.dart';

class CategoryPageItem extends StatelessWidget {
  const CategoryPageItem({super.key, required this.model});

  final DataModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          context.pushNamed(AppRoutes().category, pathParameters: {
            'id': model.id.toString(),
            'name': model.name!,
          });
        },
        child: Row(
          children: [
            Image(
              image: CachedNetworkImageProvider('${model.image}'),
              width: 160.w,
              height: 160.w,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 40.w,
            ),
            Text(
              '${model.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 50.w,
            ),
          ],
        ),
      ),
    );
  }
}
