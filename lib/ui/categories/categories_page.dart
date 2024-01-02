import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/ui/categories/cubit/categories_cubit.dart';

import '../../utils/utils.dart';
import '../widgets/default_separator.dart';
import 'widgets/category_page_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is GetCategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetCategorySuccess) {
          return ListView.separated(
              itemBuilder: (context, index) => CategoryPageItem(
                    model: state.categories.data!.data[index],
                  ),
              separatorBuilder: (context, index) => const DefaultSeparator(),
              itemCount: state.categories.data!.data.length);
        } else if (state is GetCategoryError) {
          showToast(text: state.errorMessage, state: ToastStates.error);
          return Center(
            child: OutlinedButton(
              onPressed: () {
                context.read<CategoriesCubit>().getCategories();
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
