import 'package:flutter/material.dart';
import 'package:opero/product/constant/colors.dart';
import 'package:opero/product/constant/sizes.dart';

class SocialButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const SocialButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.background(context),
          border: Border.all(color: AppColors.border(context), width: 1),
          borderRadius: BorderRadius.circular(AppSizes.radiusMD), // orta radius
        ),
        child: Center(child: icon),
      ),
    );
  }
}
