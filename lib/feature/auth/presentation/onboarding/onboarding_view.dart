import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:opero/feature/auth/presentation/onboarding/mixin/onboarding_mixin.dart';
import 'package:opero/feature/auth/presentation/onboarding/widget/onboarding_page.dart';
import 'package:opero/product/routes/route.dart';
import '../../../../product/common/appbar/onboarding_appbar.dart';
import '../../cubits/onboarding/onboarding_cubit.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with OnboardingMixin {
  @override
  Widget build(BuildContext context) {
    final totalPages = onboardingItems.length;

    return Scaffold(
      appBar: OnboardingAppBar(
        totalPages: onboardingItems.length,
        controller: controller, // PageController burada geçiliyor
      ),
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, int>(
          builder: (context, pageIndex) {
            return PageView.builder(
              controller: controller,
              itemCount: totalPages,
              onPageChanged: (i) => context.read<OnboardingCubit>().setPage(i),
              itemBuilder: (context, index) {
                final item = onboardingItems[index];
                return OnboardingPage(
                  title: item.title,
                  subtitle: item.subtitle,
                  buttonText: item.buttonText,
                  onBack: onBack,
                  onSkip: onSkip,
                  onButtonPressed: () => onButtonPressed(index),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
