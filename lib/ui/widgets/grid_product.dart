import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/repository/models/favorites_model.dart';
import 'package:salla/ui/favorites/cubit/favorites_cubit.dart';
import 'package:salla/ui/index/cubit/app_cubit.dart';
import 'package:salla/utils/router/routes.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({super.key, required this.model});

  final dynamic model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppRoutes().product,
          pathParameters: {
            'id': model.id.toString(),
            'name': model.name,
          },
        );
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: CachedNetworkImageProvider('${model.image}'),
                width: double.infinity,
                height: 350.w,
              ),
              if (model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                )
            ]),
            Expanded(
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${model.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 26.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${model.price!.round()} EG',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 26.sp,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice!.round()}EG',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              constraints: BoxConstraints.tight(
                                Size(45.w, 45.w),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                context.read<FavoritesCubit>().changeFavorite(
                                    product: Product.fromOtherModel(model),
                                    token: context.read<AppCubit>().token!);
                              },
                              icon: CircleAvatar(
                                backgroundColor: context
                                        .watch<FavoritesCubit>()
                                        .favoriteLocally
                                        .contains(Product.fromOtherModel(model))
                                    ? Colors.blue
                                    : Colors.grey,
                                child: Icon(
                                  size: 35.w,
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
