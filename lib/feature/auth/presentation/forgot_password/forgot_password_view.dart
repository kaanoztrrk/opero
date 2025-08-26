import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/forgot_password/forgot_password.dart';
import 'widget/email_step.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ForgotPasswordCubit(),
        child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state == ForgotPasswordState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error sending reset email")),
              );
            }
          },
          child: EmailStep(
            onNext: (email) {
              context.read<ForgotPasswordCubit>().sendResetEmail(
                email,
                context,
              );
            },
          ),
        ),
      ),
    );
  }
}
