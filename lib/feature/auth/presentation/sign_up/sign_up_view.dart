import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:opero/product/init/di/di.dart';
import '../../../../product/common/button/primary_button.dart';
import '../../../../product/common/field/primary_textfield.dart';
import '../../../../product/common/tile/header_tile.dart';
import '../../../../product/constant/sizes.dart';
import '../../../../product/utility/snack_bar.dart';
import '../../blocs/sign_up/sign_up_bloc.dart';
import '../../blocs/sign_up/sign_up_event.dart';
import '../../blocs/sign_up/sign_up_state.dart';
import 'mixin/sign_up_mixin.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with SignUpMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SignUpBloc>(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: handleSignUpState,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.paddingXL),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Center(
                        child: HeaderTile(
                          title: "Welcome Back",
                          subtitle: "Sign in to access your\nOpero workspace.",
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingXXL),
                      PrimaryTextField(
                        title: "Name",
                        hint: "Please enter Name",
                        prefixIcon: Iconsax.sms,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: AppSizes.spacingMD),
                      PrimaryTextField(
                        title: "Email",
                        hint: "Please enter E-mail",
                        prefixIcon: Iconsax.sms,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSizes.spacingMD),
                      PrimaryTextField(
                        isPasswordField: true,
                        title: "Password",
                        hint: "Please enter password",
                        prefixIcon: Iconsax.lock,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: AppSizes.spacingXXL),
                      state.status == SignUpStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : PrimaryButton(
                              text: "Sign Up",
                              onPressed: () {
                                final name = nameController.text.trim();
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();

                                if (name.isEmpty ||
                                    email.isEmpty ||
                                    password.isEmpty) {
                                  AppSnackBar.show(
                                    context,
                                    message: "Please fill all fields",
                                    type: SnackBarType.info,
                                    duration: const Duration(seconds: 2),
                                  );
                                  return;
                                }

                                context.read<SignUpBloc>().add(
                                  SignUpRequested(
                                    name: name,
                                    email: email,
                                    password: password,
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
