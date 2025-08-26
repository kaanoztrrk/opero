import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:opero/product/common/button/primary_button.dart';
import 'package:opero/product/common/field/primary_textfield.dart';
import 'package:opero/product/common/text/text_widget.dart';
import 'package:opero/product/common/tile/header_tile.dart';
import 'package:opero/product/constant/colors.dart';
import 'package:opero/product/constant/sizes.dart';

class EmailStep extends StatelessWidget {
  final ValueChanged<String> onNext;
  const EmailStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingXL),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeaderTile(
              showAvatar: true,
              avatarIcon: Iconsax.finger_scan,
              avatarIconColor: AppColors.primary,
              title: "Forgot Your Password\nand Continue",
              titleType: AppTextType.headlineSmall,
            ),
            SizedBox(height: AppSizes.spacingXXL * 2),

            PrimaryTextField(
              title: "Email",
              hint: "Enter your email",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: AppSizes.spacingXXL),

            PrimaryButton(
              text: "Submit Now",
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  onNext(email); // emaili gönder
                }
              },
            ),
            SizedBox(height: AppSizes.spacingXXL),

            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_rounded, size: AppSizes.iconMD),
                  const SizedBox(width: 6),
                  AppText(text: "Back to login", type: AppTextType.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
