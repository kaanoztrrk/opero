import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import '../../utility/device_utility.dart';

class AppTextFieldTheme {
  AppTextFieldTheme._();

  /// Tek theme fonksiyonu, context ile otomatik light/dark seçimi
  static InputDecorationTheme decorationTheme(BuildContext context) {
    final dark = DeviceUtils.isDarkMode(context);

    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.border(context), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      hintStyle: TextStyle(
        color: dark
            ? AppColors.textPrimary(context).withValues(alpha: 0.6)
            : AppColors.textPrimary(context).withValues(alpha: 0.6),
        fontSize: 14,
      ),
      labelStyle: TextStyle(
        color: AppColors.textPrimary(context),
        fontSize: 14,
      ),
    );
  }

  /// TextField içi TextStyle
  static TextStyle textStyle(BuildContext context) {
    return TextStyle(color: AppColors.textPrimary(context), fontSize: 14);
  }
}
