import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opero/product/routes/route.dart';

mixin SplashMixin<T extends StatefulWidget> on State<T> {
  Future<void> handleNavigation(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    final firstLaunch = prefs.getBool('first_launch') ?? true;
    if (firstLaunch) {
      await prefs.setBool('first_launch', false);
      context.pushReplacement(AppRoutes.onBoardingView);
      return;
    }

    // İlk açılış değil, kullanıcı giriş kontrolü
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final hasCompany = doc.data()?['hasCompany'] ?? false;

        if (hasCompany) {
          context.pushReplacement(AppRoutes.mainView);
        } else {
          context.pushReplacement(AppRoutes.selectCompanyView);
        }
      } catch (e) {
        context.pushReplacement(AppRoutes.signInView);
      }
    } else {
      context.pushReplacement(AppRoutes.signInView);
    }
  }
}
