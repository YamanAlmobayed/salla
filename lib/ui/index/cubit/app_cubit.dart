import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salla/ui/profile/profile_page.dart';

import '../../../repository/models/on_boarding_model.dart';
import '../../../utils/cache_helper.dart';
import '../../categories/categories_page.dart';
import '../../favorites/favorites_page.dart';
import '../../home/home_page.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  String? token;

  bool? onBoarding;

  void checkOnBoarding(bool? localStorageOnBoarding) {
    if (localStorageOnBoarding == null) return;
    onBoarding ??= localStorageOnBoarding;
  }

  void checkToken(String? localStoragetoken) {
    if (localStoragetoken == null) return;
    token ??= localStoragetoken;
  }

  List<OnBoardingModel> onboarding = [
    OnBoardingModel(
      image: 'assets/images/onboarding_1.jpg',
      title: 'Welcome to Salla!!!',
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding_2.jpg',
      title: 'Search for the product you wants',
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding_3.jpg',
      title: 'Choose a deal that fit your needs 🔥🔥🔥',
    ),
  ];

  void onBoardingSubmit(context) async {
    onBoarding = true;
    await CacheHelper.saveData(key: 'onBoarding', value: true);
  }

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const HomePage(),
    const CategoriesPage(),
    const FavoritePage(),
    ProfilePage(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavIndex());
  }

  void signOut(context) async {
    token = null;
    await CacheHelper().removeData(key: 'token');
  }
}
