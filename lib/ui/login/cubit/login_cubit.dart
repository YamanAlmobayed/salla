import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salla/repository/models/login_model.dart';
import 'package:salla/repository/shop_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.shopRepository}) : super(LoginInitial());
  final ShopRepository shopRepository;

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final user = await shopRepository.login(email: email, password: password);
      if (user.status!) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginError(user.message!));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  IconData suffix = Icons.visibility_off;

  bool isPassword = true;

  void toggleLoginPasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(TogglePasswordVisibility());
  }
}
