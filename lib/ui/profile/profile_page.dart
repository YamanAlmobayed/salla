import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/ui/index/cubit/app_cubit.dart';
import 'package:salla/ui/profile/cubit/profile_cubit.dart';
import 'package:salla/utils/router/routes.dart';

import '../../utils/utils.dart';
import '../widgets/default_button.dart';
import '../widgets/default_formfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is GetUserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetUserSuccess ||
            state is UpdateUserSuccess ||
            state is UpdateUserLoading) {
          if (state is GetUserSuccess) {
            nameController.text = state.user.data!.name!;
            emailController.text = state.user.data!.email!;
            phoneController.text = state.user.data!.phone!;
          } else if (state is UpdateUserSuccess) {
            nameController.text = state.updatedUser.data!.name!;
            emailController.text = state.updatedUser.data!.email!;
            phoneController.text = state.updatedUser.data!.phone!;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UpdateUserLoading)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      prefix: Icons.person,
                      label: 'Name',
                      validate: (value) {
                        if (value.isEmpty) return 'Name can\'t be empty';
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
                        if (value.isEmpty) return 'Email can\'t be empty';
                        return null;
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
                        if (value.isEmpty) return 'Phone can\'t be empty';
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            context.read<ProfileCubit>().updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  token: context.read<AppCubit>().token!,
                                );
                          }
                        },
                        text: 'Update'),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                        function: () {
                          context.read<AppCubit>().signOut(context);
                          context.pushReplacementNamed(AppRoutes().login);
                        },
                        text: 'LOGOUT'),
                  ],
                ),
              ),
            ),
          );
        } else if (state is GetUserError || state is UpdateUserError) {
          if (state is GetUserError) {
            showToast(text: state.errorMessage, state: ToastStates.error);
          } else if (state is UpdateUserError) {
            showToast(text: state.errorMessage, state: ToastStates.error);
          }

          return Center(
            child: OutlinedButton(
              onPressed: () {
                context
                    .read<ProfileCubit>()
                    .getUser(context.read<AppCubit>().token);
              },
              child: const Text('Retry'),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
