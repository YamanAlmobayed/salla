import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/repository/models/favorites_model.dart';
import 'package:salla/utils/router/routes.dart';

import '../../favorites/cubit/favorites_cubit.dart';
import '../../index/cubit/app_cubit.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.model, required this.isSearch});

  final dynamic model;
  final bool isSearch;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () => context.pushNamed(
          AppRoutes().product,
          pathParameters: {
            'id': widget.model.id.toString(),
            'name': widget.model.name,
          },
        ),
        child: SizedBox(
          height: 220.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  image: CachedNetworkImageProvider('${widget.model.image}'),
                  width: 240.w,
                  height: 240.w,
                ),
                if (widget.model.discount != 0 && !widget.isSearch)
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
              SizedBox(
                width: 40.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.model.name}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 30.sp,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${widget.model.price} EG',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        if (widget.model.discount != 0 && !widget.isSearch)
                          Text(
                            '${widget.model.oldPrice} EG',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          constraints: BoxConstraints.tight(
                            Size(50.w, 50.w),
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            context.read<FavoritesCubit>().changeFavorite(
                                product: Product.fromOtherModel(widget.model),
                                token: context.read<AppCubit>().token!);
                          },
                          icon: CircleAvatar(
                            backgroundColor: context
                                    .watch<FavoritesCubit>()
                                    .favoriteLocally
                                    .contains(
                                        Product.fromOtherModel(widget.model))
                                ? Colors.blue
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 35.w,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
