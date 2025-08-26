import 'package:flutter/material.dart';
import '../utility/device_utility.dart';

class AppColors {
  AppColors._();

  // Kurumsal Renkler
  static const Color primary = Color(0xFF0D3B66);
  static const Color secondary = Color(0xFF1D4E89);
  static const Color accent = Color(0xFFFFB703);

  // Durum Renkleri
  static const Color error = Color(0xFFD90429);
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFA500);

  // Light/Dark renkler (private)
  static const _lightBackground = Color(0xFFF7F7F7);
  static const _darkBackground = Color(0xFF121212);

  static const _lightCard = Color(0xFFFFFFFF);
  static const _darkCard = Color(0xFF1E1E1E);

  static const _lightTextPrimary = Color(0xFF1A1A1A);
  static const _darkTextPrimary = Color(0xFFE0E0E0);

  static const _lightTextSecondary = Color(0xFF1A1A1A);
  static const _darkTextSecondary = Color(0xFFE0E0E0);

  static const _lightBorder = Color(0xFFE0E0E0);
  static const _darkBorder = Color(0xFF444444);

  // -------------------- Tema Bazlı Getter --------------------
  static Color background(BuildContext context) =>
      DeviceUtils.isDarkMode(context) ? _darkBackground : _lightBackground;

  static Color widgetColor(BuildContext context) =>
      DeviceUtils.isDarkMode(context) ? _lightBackground : _darkBackground;

  static Color buttonTextColor(BuildContext context) =>
      DeviceUtils.isDarkMode(context) ? _darkBackground : _lightBackground;

  static Color card(BuildContext context) =>
      DeviceUtils.isDarkMode(context) ? _darkCard : _lightCard;

  static Color textPrimary(BuildContext context) =>
      DeviceUtils.isDarkMode(context) ? _darkTextPrimary : _lightTextPrimary;

  static Color textSecondary(BuildContext context) =>
      DeviceUtils.isDarkMode(context)
      ? _darkTextSecondary
      : _lightTextSecondary;

  static Color border(BuildContext context) =>
      DeviceUtils.isDarkMode(context) ? _darkBorder : _lightBorder;
}
