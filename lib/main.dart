import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla/repository/services/shop_service.dart';
import 'package:salla/repository/shop_repository.dart';
import 'package:salla/ui/categories/cubit/categories_cubit.dart';
import 'package:salla/ui/favorites/cubit/favorites_cubit.dart';
import 'package:salla/ui/home/cubit/home_cubit.dart';
import 'package:salla/ui/index/cubit/app_cubit.dart';
import 'package:salla/ui/profile/cubit/profile_cubit.dart';
import 'package:salla/ui/style/app_theme.dart';
import 'package:salla/utils/bloc_observer.dart';
import 'package:salla/utils/cache_helper.dart';
import 'package:salla/utils/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.inti();
  bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  String? token = CacheHelper.getData(key: "token");

  runApp(MyApp(token: token, onBoarding: onBoarding));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.token, required this.onBoarding});
  final String? token;
  final bool? onBoarding;

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ShopRepository(shopService: ShopService()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit()
              ..checkToken(token)
              ..checkOnBoarding(onBoarding),
          ),
          BlocProvider(
            create: (context) =>
                HomeCubit(shopRepository: context.read<ShopRepository>())
                  ..getHomeData(),
          ),
          BlocProvider(
            create: (context) =>
                CategoriesCubit(shopRepository: context.read<ShopRepository>())
                  ..getCategories(),
          ),
          BlocProvider(
            create: (context) =>
                FavoritesCubit(shopRepository: context.read<ShopRepository>())
                  ..getFavorite(token),
          ),
          BlocProvider(
            create: (context) =>
                ProfileCubit(shopRepository: context.read<ShopRepository>())
                  ..getUser(token),
          ),
        ],
        child: Builder(
          builder: (context) => ScreenUtilInit(
            designSize: const Size(737, 392),
            minTextAdapt: true,
            builder: (context, child) => MaterialApp.router(
              title: 'Salla',
              debugShowCheckedModeBanner: false,
              theme: AppStyle().lightTheme,
              routerConfig: _appRouter.router,
              // builder: (context, router) => router!,
            ),
          ),
        ),
      ),
    );
  }
}
