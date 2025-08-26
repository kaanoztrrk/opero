import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:opero/product/routes/route.dart';

enum ForgotPasswordState { initial, loading, success, error }

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState.initial);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendResetEmail(String email, BuildContext context) async {
    emit(ForgotPasswordState.loading);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(ForgotPasswordState.success);
      // Başarıyla mail gönderildi → login sayfasına dön
      context.go(AppRoutes.signInView);
    } catch (e) {
      emit(ForgotPasswordState.error);
    }
  }
}
