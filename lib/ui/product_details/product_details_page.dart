import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:salla/repository/models/favorites_model.dart';
import 'package:salla/repository/shop_repository.dart';
import 'package:salla/ui/favorites/cubit/favorites_cubit.dart';
import 'package:salla/ui/index/cubit/app_cubit.dart';
import 'package:salla/ui/product_details/cubit/product_details_cubit.dart';

import '../../utils/utils.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage(
      {super.key, required this.productId, required this.productName});
  final int productId;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(
        shopRepository: context.read<ShopRepository>(),
      )..getProductDetails(productId),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is GetProductDetailsLoading) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is GetProductDetailsSuccess) {
            final product =
                Product.fromOtherModel(state.productDetails.product);
            return Scaffold(
              appBar: AppBar(
                title: Text(productName),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      constraints: BoxConstraints.tight(
                        Size(45.w, 45.w),
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        context.read<FavoritesCubit>().changeFavorite(
                            product: product,
                            token: context.read<AppCubit>().token!);
                      },
                      icon: CircleAvatar(
                        backgroundColor: context
                                .watch<FavoritesCubit>()
                                .favoriteLocally
                                .contains(product)
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
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    CarouselSlider(
                      items: state.productDetails.product!.images!
                          .map((e) => Image(
                                image: CachedNetworkImageProvider(e!),
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 450.w,
                        viewportFraction: 1.0,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 40.0.w,
                    ),
                    Text(
                      'Price:',
                      style: TextStyle(
                        fontSize: 40.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${state.productDetails.product!.price!} EG',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30.0.sp,
                          ),
                        ),
                        SizedBox(
                          width: 20.0.w,
                        ),
                        if (state.productDetails.product!.discount! > 0)
                          Text(
                            '${state.productDetails.product!.oldPrice!} EG',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 30.sp,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      'Details:',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ReadMoreText(
                      state.productDetails.product!.description!,
                      style: TextStyle(fontSize: 30.sp),
                      trimLines: 5,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      lessStyle: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetProductDetailsError) {
            showToast(text: state.errorMessage, state: ToastStates.error);
            return Material(
              child: Center(
                child: OutlinedButton(
                  onPressed: () {
                    context
                        .read<ProductDetailsCubit>()
                        .getProductDetails(productId);
                  },
                  child: const Text('Retry'),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
