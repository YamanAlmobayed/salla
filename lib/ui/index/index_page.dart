import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/ui/index/cubit/app_cubit.dart';
import 'package:salla/utils/router/routes.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salla',
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(AppRoutes().search);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: context
          .read<AppCubit>()
          .bottomScreens[context.read<AppCubit>().currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<AppCubit>().currentIndex,
        onTap: (index) {
          context.read<AppCubit>().changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_sharp,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
