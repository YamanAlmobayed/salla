import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salla/repository/shop_repository.dart';

import '../../../repository/models/login_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.shopRepository}) : super(RegisterInitial());
  final ShopRepository shopRepository;

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoading());
    try {
      final user = await shopRepository.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      if (user.status!) {
        emit(RegisterSuccess(user));
      } else {
        emit(RegisterError(user.message!));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  IconData suffix = Icons.visibility_off;

  bool isPassword = true;

  void toggleRegisterPasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(TogglePasswordVisibility());
  }
}
