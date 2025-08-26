import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../product/routes/route.dart';
import '../../../../../product/utility/snack_bar.dart';
import '../../../blocs/sign_up/sign_up_bloc.dart';
import '../../../blocs/sign_up/sign_up_event.dart';
import '../../../blocs/sign_up/sign_up_state.dart';

mixin SignUpMixin<T extends StatefulWidget> on State<T> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleSignUpState(BuildContext context, SignUpState state) async {
    if (state.status == SignUpStatus.failure) {
      AppSnackBar.show(
        context,
        message: state.errorMessage ?? "Unknown error",
        type: SnackBarType.error,
        duration: const Duration(seconds: 2),
      );
    } else if (state.status == SignUpStatus.success) {
      AppSnackBar.show(
        context,
        message: "Sign up successful!",
        type: SnackBarType.success,
        duration: const Duration(seconds: 2),
      );
      // SnackBar 2 saniye görünsün, sonra yönlendirme
      await Future.delayed(const Duration(seconds: 2));
      context.go(AppRoutes.signInView);
    }
  }

  void submit() {}
}
