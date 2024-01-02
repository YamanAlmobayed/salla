import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/repository/shop_repository.dart';
import 'package:salla/ui/category_details/cubit/category_details_cubit.dart';
import 'package:salla/ui/home/widget/products_grid.dart';

import '../../utils/utils.dart';

class CategoryDetailsPage extends StatelessWidget {
  const CategoryDetailsPage(
      {super.key, required this.categoryName, required this.categoryId});

  final String categoryName;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: BlocProvider(
        create: (context) => CategoryDetailsCubit(
          shopRepository: context.read<ShopRepository>(),
        )..getCategoryDetails(categoryId),
        child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
          builder: (context, state) {
            if (state is GetCategoryDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetCategoryDetailsSuccess) {
              return ProductsGrid(
                categoryProducts: state.categoryDetails.data!.data!,
              );
            } else if (state is GetCategoryDetailsError) {
              showToast(text: state.errorMessage, state: ToastStates.error);
              return Center(
                child: OutlinedButton(
                  onPressed: () {
                    context
                        .read<CategoryDetailsCubit>()
                        .getCategoryDetails(categoryId);
                  },
                  child: const Text('Retry'),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
