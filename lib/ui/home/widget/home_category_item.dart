import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/utils/router/routes.dart';

import '../../../repository/models/categories_model.dart';

class HomeCategoryItem extends StatelessWidget {
  const HomeCategoryItem({super.key, required this.model});
  final DataModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes().category, pathParameters: {
          'id': model.id.toString(),
          'name': model.name!,
        });
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: CachedNetworkImageProvider('${model.image}'),
            width: 200.w,
            height: 200.w,
            fit: BoxFit.cover,
          ),
          Container(
              width: 200.w,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
