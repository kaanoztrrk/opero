import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../utility/device_utility.dart';
import 'custom/elevation_button_theme.dart';
import 'custom/field_theme.dart';
import 'custom/text_theme.dart';

class AppTheme {
  AppTheme._();

  /// Tek fonksiyon ile context tabanlı light/dark seçimi
  static ThemeData theme(BuildContext context) {
    final dark = DeviceUtils.isDarkMode(context);

    final colorScheme = ColorScheme(
      brightness: dark ? Brightness.dark : Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      surface: AppColors.card(context),
      onSurface: AppColors.textPrimary(context),
      error: AppColors.error,
      onError: Colors.white,
      tertiary: AppColors.accent,
      onTertiary: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: AppColors.background(context),
      primaryColor: colorScheme.primary,
      textTheme: AppTextTheme.textTheme(context),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      cardColor: AppColors.card(context),
      inputDecorationTheme: AppTextFieldTheme.decorationTheme(context),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppButtonTheme.elevatedButtonStyle(context),
      ),
    );
  }
}
