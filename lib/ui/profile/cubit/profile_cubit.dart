import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salla/repository/models/login_model.dart';
import 'package:salla/repository/shop_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.shopRepository}) : super(ProfileInitial());

  final ShopRepository shopRepository;

  void getUser(String? token) async {
    if (token == null) return;
    emit(GetUserLoading());
    try {
      final user = await shopRepository.getUser(token);
      emit(GetUserSuccess(user));
    } catch (e) {
      emit(GetUserError(e.toString()));
    }
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
    required String token,
  }) async {
    emit(UpdateUserLoading());
    try {
      final updatedUser = await shopRepository.updateUserData(
          name: name, email: email, phone: phone, token: token);
      emit(UpdateUserSuccess(updatedUser));
    } catch (e) {
      emit(UpdateUserError(e.toString()));
    }
  }
}
