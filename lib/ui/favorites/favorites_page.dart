import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/ui/favorites/cubit/favorites_cubit.dart';
import 'package:salla/ui/index/cubit/app_cubit.dart';

import '../../utils/utils.dart';
import '../search/widgets/product_list.dart';
import '../widgets/default_separator.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is GetFavoritesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetFavoritesSuccess ||
            state is ChangeFavoriteLocallySuccess) {
          if (context.watch<FavoritesCubit>().favoriteLocally.isEmpty) {
            return const Center(
              child: Text(
                'You Have No Favorite Product Yet!!!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) => ProductList(
                model: context.watch<FavoritesCubit>().favoriteLocally[index],
                isSearch: false,
              ),
              separatorBuilder: (context, index) => const DefaultSeparator(),
              itemCount: context.watch<FavoritesCubit>().favoriteLocally.length,
            );
          }
        } else if (state is GetFavoritesError) {
          showToast(text: state.errorMessage, state: ToastStates.error);
          return Center(
            child: OutlinedButton(
              onPressed: () {
                context.read<FavoritesCubit>().getFavorite(
                      context.read<AppCubit>().token,
                    );
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
