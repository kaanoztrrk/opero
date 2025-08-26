import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:opero/feature/auth/cubits/splash/splash_cubit.dart';
import 'package:opero/product/common/text/text_widget.dart';
import 'package:opero/product/constant/colors.dart';
import 'package:opero/product/constant/sizes.dart';
import 'package:opero/product/routes/route.dart';

import 'mixin/splash_mixin.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SplashMixin {
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  Future<void> startSplash() async {
    // 2 saniye bekleyip sonra navigation kontrolü yap
    await Future.delayed(const Duration(seconds: 2));
    handleNavigation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            AppText(text: "Opero", type: AppTextType.headlineLarge),
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(height: AppSizes.buttonHeightLG),
          ],
        ),
      ),
    );
  }
}
