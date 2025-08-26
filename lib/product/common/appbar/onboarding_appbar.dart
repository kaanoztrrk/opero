import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../feature/auth/cubits/onboarding/onboarding_cubit.dart';
import '../../constant/colors.dart';
import '../text/text_widget.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int totalPages;
  final PageController controller; // ekledik

  const OnboardingAppBar({
    super.key,
    required this.totalPages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BlocBuilder<OnboardingCubit, int>(
        builder: (context, pageIndex) {
          return pageIndex != 0
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.widgetColor(context),
                  ),
                  onPressed: () {
                    // PageController ile sayfayı geri al
                    controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    // Cubit’i de güncelle
                    context.read<OnboardingCubit>().previous();
                  },
                )
              : const SizedBox(width: kToolbarHeight);
        },
      ),
      title: BlocBuilder<OnboardingCubit, int>(
        builder: (context, pageIndex) {
          double targetProgress = totalPages > 1
              ? (pageIndex + 1) / totalPages
              : 1.0;

          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: targetProgress),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  backgroundColor: AppColors.background(context),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              );
            },
          );
        },
      ),
      actions: [
        BlocBuilder<OnboardingCubit, int>(
          builder: (context, pageIndex) {
            bool isLastPage = pageIndex == totalPages - 1;
            return TextButton(
              onPressed: isLastPage
                  ? null
                  : () {
                      // PageController ile son sayfaya geç
                      controller.animateToPage(
                        totalPages - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                      // Cubit’i de güncelle
                      context.read<OnboardingCubit>().skipToEnd(totalPages);
                    },
              child: AppText(
                text: "Skip",
                type: AppTextType.bodyLarge,
                color: isLastPage
                    ? AppColors.textSecondary(context)
                    : AppColors.textPrimary(context),
              ),
            );
          },
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
