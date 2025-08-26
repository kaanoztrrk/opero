import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../product/routes/route.dart';
import '../../../cubits/onboarding/onboarding_cubit.dart';
import '../onboarding_view.dart';

mixin OnboardingMixin on State<OnboardingView> {
  final PageController controller = PageController();
  final int totalPages = 3;

  List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome to Opero!',
      subtitle: 'Discover a smarter way to manage your company’s vehicles...',
      buttonText: 'Next',
    ),
    OnboardingItem(
      title: 'Efficient Vehicle Management',
      subtitle: 'Add new vehicles, view existing ones, and monitor status...',
      buttonText: 'Next',
    ),
    OnboardingItem(
      title: 'Stay Connected with Your Company',
      subtitle: 'Access detailed info about your company’s vehicles...',
      buttonText: 'Next',
    ),
    OnboardingItem(
      title: 'Ready to Get Started',
      subtitle: 'Vehicle management has never been easier...',
      buttonText: 'Get Started',
    ),
  ];

  double get progress {
    final cubitState = context.read<OnboardingCubit>().state;
    return cubitState / (onboardingItems.length - 1);
  }

  void onSkip() {
    final lastIndex = onboardingItems.length - 1;
    controller.animateToPage(
      lastIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    context.read<OnboardingCubit>().skipToEnd(onboardingItems.length);
  }

  void onBack() {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    context.read<OnboardingCubit>().previous();
  }

  void onButtonPressed(int index) {
    if (index < onboardingItems.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      context.read<OnboardingCubit>().next(onboardingItems.length);
    } else {
      print("Done");

      context.go(AppRoutes.signInView);
    }
  }
}

class OnboardingItem {
  final String title;
  final String subtitle;
  final String buttonText;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });
}
