import 'package:flutter/material.dart';
import 'package:opero/product/constant/colors.dart';
import '../../utility/device_utility.dart';

class AppButtonTheme {
  AppButtonTheme._();

  /// Tek fonksiyon ile context tabanlı light/dark switch
  static ButtonStyle elevatedButtonStyle(BuildContext context) {
    final dark = DeviceUtils.isDarkMode(context);

    return ElevatedButton.styleFrom(
      backgroundColor: dark ? AppColors.background(context) : AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
