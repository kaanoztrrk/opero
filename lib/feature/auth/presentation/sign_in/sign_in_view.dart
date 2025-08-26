import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:opero/feature/auth/blocs/sign_in/sign_in_bloc.dart';
import 'package:opero/product/common/button/primary_button.dart';
import 'package:opero/product/common/field/primary_textfield.dart';
import 'package:opero/product/common/text/text_widget.dart';
import 'package:opero/product/common/tile/header_tile.dart';
import 'package:opero/product/constant/sizes.dart';
import 'package:opero/product/init/di/di.dart';
import 'package:opero/product/routes/route.dart';
import '../../blocs/sign_in/sign_in_event.dart';
import '../../blocs/sign_in/sign_in_state.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SignInBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingXL),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //* Header
                  Center(
                    child: HeaderTile(
                      title: "Welcome Back",
                      subtitle: "Sign in to access your\nOpero workspace.",
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingXXL * 2),

                  //* Email
                  PrimaryTextField(
                    controller: _emailController,
                    title: "Email",
                    hint: "Please enter E-mail",
                    prefixIcon: Iconsax.sms,
                  ),
                  SizedBox(height: AppSizes.spacingMD),

                  //* Password
                  PrimaryTextField(
                    controller: _passwordController,
                    isPasswordField: true,
                    title: "Password",
                    hint: "Please enter password",
                    prefixIcon: Iconsax.lock,
                  ),
                  SizedBox(height: AppSizes.spacingSM),

                  //* Forgot Password
                  InkWell(
                    onTap: () {
                      context.push(AppRoutes.forgotPasswordView);
                    },
                    child: AppText(
                      text: "Forgot Password?",
                      type: AppTextType.bodyLarge,
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingXXL),

                  //* BlocConsumer ile Button ve state yönetimi
                  BlocConsumer<SignInBloc, SignInState>(
                    listener: (context, state) async {
                      if (state.status == SignInStatus.success) {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          try {
                            final doc = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .get();
                            final hasCompany =
                                doc.data()?['hasCompany'] ?? false;

                            if (hasCompany) {
                              context.go(AppRoutes.mainView);
                            } else {
                              context.go(AppRoutes.selectCompanyView);
                            }
                          } catch (e) {
                            // Firestore hatası olursa SignInView’e geri yönlendir
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Error checking company: ${e.toString()}',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            context.go(AppRoutes.signInView);
                          }
                        }
                      } else if (state.status == SignInStatus.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.errorMessage ?? "Unknown error",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },

                    builder: (context, state) {
                      return state.status == SignInStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : PrimaryButton(
                              text: "Sign In",
                              onPressed: () {
                                final email = _emailController.text.trim();
                                final password = _passwordController.text
                                    .trim();
                                context.read<SignInBloc>().add(
                                  SignInRequested(
                                    email: email,
                                    password: password,
                                  ),
                                );
                              },
                            );
                    },
                  ),
                  SizedBox(height: AppSizes.spacingXXL),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: "Don't have an account?",
                        type: AppTextType.bodyLarge,
                      ),
                      SizedBox(width: AppSizes.spacingSM / 2),

                      InkWell(
                        onTap: () {
                          context.push(AppRoutes.signUpView);
                        },
                        child: AppText(
                          text: "Sign Up",
                          type: AppTextType.bodyLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSizes.spacingXXL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
