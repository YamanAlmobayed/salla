import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/ui/favorites/cubit/favorites_cubit.dart';
import 'package:salla/ui/profile/cubit/profile_cubit.dart';
import 'package:salla/ui/register/cubit/register_cubit.dart';
import 'package:salla/utils/router/routes.dart';

import '../../../utils/cache_helper.dart';
import '../../../utils/utils.dart';
import '../../index/cubit/app_cubit.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_formfield.dart';

class RegisterLayout extends StatefulWidget {
  const RegisterLayout({super.key});

  @override
  State<RegisterLayout> createState() => _RegisterLayoutState();
}

class _RegisterLayoutState extends State<RegisterLayout> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (_, state) async {
        if (state is RegisterSuccess) {
          await CacheHelper.saveData(
              key: 'token', value: state.user.data!.token);
          // ignore: use_build_context_synchronously
          context.read<AppCubit>().token = state.user.data!.token!;
          // ignore: use_build_context_synchronously
          context.read<ProfileCubit>().getUser(state.user.data!.token);
          // ignore: use_build_context_synchronously
          context.read<FavoritesCubit>().getFavorite(state.user.data!.token);
          // ignore: use_build_context_synchronously
          context.pushReplacementNamed(AppRoutes().index);
        } else if (state is RegisterError) {
          showToast(text: state.errorMessage, state: ToastStates.error);
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    'Register now to browse our hot offers',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DefaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: Icons.person,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Name can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    prefix: Icons.email_outlined,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Email can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                        current is TogglePasswordVisibility,
                    builder: (context, state) {
                      return DefaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: context.read<RegisterCubit>().suffix,
                        isPassword: context.read<RegisterCubit>().isPassword,
                        label: 'Password',
                        prefix: Icons.lock,
                        onPress: () {
                          context
                              .read<RegisterCubit>()
                              .toggleRegisterPasswordVisibility();
                        },
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: Icons.phone,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Phone can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                        current is RegisterInitial ||
                        current is RegisterLoading ||
                        current is RegisterError ||
                        current is RegisterSuccess,
                    builder: (context, state) {
                      if (state is RegisterInitial || state is RegisterError) {
                        return DefaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                context.read<RegisterCubit>().register(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                              }
                            },
                            text: 'Register');
                      } else if (state is RegisterLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
