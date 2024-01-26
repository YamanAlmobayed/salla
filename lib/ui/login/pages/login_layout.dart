import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/ui/favorites/cubit/favorites_cubit.dart';
import 'package:salla/ui/login/cubit/login_cubit.dart';
import 'package:salla/ui/profile/cubit/profile_cubit.dart';
import 'package:salla/utils/router/routes.dart';

import '../../../utils/cache_helper.dart';
import '../../../utils/utils.dart';
import '../../index/cubit/app_cubit.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_formfield.dart';
import '../../widgets/default_text_button.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({super.key});

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          await CacheHelper.saveData(
              key: 'token', value: state.user.data!.token);
          // ignore: use_build_context_synchronously
          context.read<AppCubit>().token = state.user.data!.token!;
          // ignore: use_build_context_synchronously
          context.read<FavoritesCubit>().getFavorite(state.user.data!.token);
          // ignore: use_build_context_synchronously
          context.read<ProfileCubit>().getUser(state.user.data!.token);
          // ignore: use_build_context_synchronously
          context.replaceNamed(AppRoutes().index);
          // // ignore: use_build_context_synchronously
          // navigateAndFinish(context, const Index());
        } else if (state is LoginError) {
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
                    'LOGIN',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    'Login now to browse our hot offers',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
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
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        current is TogglePasswordVisibility,
                    builder: (context, state) {
                      return DefaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: context.read<LoginCubit>().suffix,
                          isPassword: context.read<LoginCubit>().isPassword,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          onPress: () {
                            context
                                .read<LoginCubit>()
                                .toggleLoginPasswordVisibility();
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        current is LoginInitial ||
                        current is LoginLoading ||
                        current is LoginError ||
                        current is LoginSuccess,
                    builder: (context, state) {
                      if (state is LoginInitial || state is LoginError) {
                        return DefaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'Login');
                      } else if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account ?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      DefaultTextButton(
                          onPressed: () {
                            context.pushNamed(AppRoutes().register);
                            // navigateAndFinish(context, const RegisterPage());
                          },
                          text: 'Register'),
                    ],
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
