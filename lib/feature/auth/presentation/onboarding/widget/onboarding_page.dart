import 'package:flutter/material.dart';
import 'package:opero/product/common/button/primary_button.dart';
import 'package:opero/product/common/text/text_widget.dart';
import 'package:opero/product/constant/colors.dart';
import 'package:opero/product/constant/sizes.dart';

import '../../../../../product/common/appbar/onboarding_appbar.dart';

class OnboardingPage extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSkip;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Widget? topContent; // üstte resim veya icon eklemek için opsiyonel

  const OnboardingPage({
    super.key,

    required this.onBack,
    required this.onSkip,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
    this.topContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Üstte opsiyonel içerik
          Expanded(flex: 5, child: topContent ?? Container()),

          // Alt kart içerik
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.radiusXL),
                  topRight: Radius.circular(AppSizes.radiusXL),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.paddingXL * 2,
                  bottom: AppSizes.paddingXXL,
                  right: AppSizes.paddingXL,
                  left: AppSizes.paddingXL,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    AppText(
                      text: title,
                      type: AppTextType.headlineLarge,
                      textAlign: TextAlign.center,
                    ),

                    // Subtitle
                    AppText(
                      text: subtitle,
                      type: AppTextType.titleSmall,
                      textAlign: TextAlign.center,
                    ),

                    // Button
                    PrimaryButton(text: buttonText, onPressed: onButtonPressed),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
