import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/ui/category_details/category_details_page.dart';
import 'package:salla/ui/index/cubit/app_cubit.dart';
import 'package:salla/ui/index/index_page.dart';
import 'package:salla/ui/login/pages/login_page.dart';
import 'package:salla/ui/onboarding/on_boarding_page.dart';
import 'package:salla/ui/product_details/product_details_page.dart';
import 'package:salla/ui/register/pages/register_page.dart';
import 'package:salla/ui/search/search_page.dart';
import 'package:salla/utils/router/routes.dart';

class AppRouter {
  GoRouter router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: [
      GoRoute(
        name: AppRoutes().index,
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: Index(),
        ),
      ),
      GoRoute(
        name: AppRoutes().onBoarding,
        path: '/onBoarding',
        pageBuilder: (context, state) => const MaterialPage(
          child: OnBoardingPage(),
        ),
      ),
      GoRoute(
        name: AppRoutes().login,
        path: '/login',
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginPage(),
        ),
      ),
      GoRoute(
        name: AppRoutes().register,
        path: '/register',
        pageBuilder: (context, state) => const MaterialPage(
          child: RegisterPage(),
        ),
      ),
      GoRoute(
          name: AppRoutes().product,
          path: '/product/:id,:name',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: ProductDetailsPage(
                productId: int.parse(state.pathParameters['id']!),
                productName: state.pathParameters['name']!,
              ),
            );
          }),
      GoRoute(
          name: AppRoutes().category,
          path: '/category/:id,:name',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: CategoryDetailsPage(
                categoryId: int.parse(state.pathParameters['id']!),
                categoryName: state.pathParameters['name']!,
              ),
            );
          }),
      GoRoute(
          name: AppRoutes().search,
          path: '/search',
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: SearchPage(),
            );
          }),
    ],
    redirect: (context, state) {
      if (state.matchedLocation == '/') {
        if (context.read<AppCubit>().onBoarding == null) {
          return state.namedLocation(AppRoutes().onBoarding);
        } else {
          if (context.read<AppCubit>().token == null) {
            return state.namedLocation(AppRoutes().login);
          } else {
            return state.namedLocation(AppRoutes().index);
          }
        }
      }
      return null;
    },
  );
}
