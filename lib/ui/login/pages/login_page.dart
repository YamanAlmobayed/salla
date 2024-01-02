import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/repository/shop_repository.dart';
import 'package:salla/ui/login/cubit/login_cubit.dart';
import 'package:salla/ui/login/pages/login_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(shopRepository: context.read<ShopRepository>()),
      child: Scaffold(
        appBar: AppBar(),
        body: const LoginLayout(),
      ),
    );
  }
}
