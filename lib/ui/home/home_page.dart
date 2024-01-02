import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla/ui/categories/cubit/categories_cubit.dart';
import 'package:salla/ui/home/cubit/home_cubit.dart';
import 'package:salla/ui/home/widget/categories_widget.dart';
import 'package:salla/ui/home/widget/custom_carousel.dart';
import 'package:salla/ui/home/widget/products_grid.dart';
import 'package:salla/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final categoriesCubitState = context.watch<CategoriesCubit>().state;
        if (state is GetHomeLoading ||
            categoriesCubitState is GetCategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetHomeSuccess &&
            categoriesCubitState is GetCategorySuccess) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCarousel(
                  banners: state.homeData.data!.banners,
                ),
                SizedBox(
                  height: 10.w,
                ),
                CategoriesWidget(
                  categories: categoriesCubitState.categories.data!.data,
                ),
                SizedBox(
                  height: 10.w,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductsGrid(
                    homeProducts: state.homeData.data!.products,
                  ),
                ),
              ],
            ),
          );
        } else if (state is GetHomeError) {
          showToast(text: state.errorMessage, state: ToastStates.error);
          return Center(
            child: OutlinedButton(
              onPressed: () {
                context.read<HomeCubit>().getHomeData();
              },
              child: const Text('Retry'),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
