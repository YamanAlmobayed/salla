import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/repository/shop_repository.dart';
import 'package:salla/ui/register/cubit/register_cubit.dart';
import 'package:salla/ui/register/pages/register_layout.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterCubit(shopRepository: context.read<ShopRepository>()),
      child: Scaffold(
        appBar: AppBar(),
        body: const RegisterLayout(),
      ),
    );
  }
}
