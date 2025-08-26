import 'package:flutter/material.dart';
import '../../theme/custom/text_theme.dart';
import '../../constant/colors.dart';
import '../../utility/device_utility.dart';

enum AppTextType {
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextType type;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  // Opsiyonel override parametreleri
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final FontStyle? fontStyle;
  final double? height;

  const AppText({
    super.key,
    required this.text,
    required this.type,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.fontStyle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme(context);

    TextStyle style;

    switch (type) {
      case AppTextType.headlineLarge:
        style = textTheme.headlineLarge!;
        break;
      case AppTextType.headlineMedium:
        style = textTheme.headlineMedium!;
        break;
      case AppTextType.headlineSmall:
        style = textTheme.headlineSmall!;
        break;
      case AppTextType.titleLarge:
        style = textTheme.titleLarge!;
        break;
      case AppTextType.titleMedium:
        style = textTheme.titleMedium!;
        break;
      case AppTextType.titleSmall:
        style = textTheme.titleSmall!;
        break;
      case AppTextType.bodyLarge:
        style = textTheme.bodyLarge!;
        break;
      case AppTextType.bodyMedium:
        style = textTheme.bodyMedium!;
        break;
      case AppTextType.bodySmall:
        style = textTheme.bodySmall!;
        break;
      case AppTextType.labelLarge:
        style = textTheme.labelLarge!;
        break;
      case AppTextType.labelMedium:
        style = textTheme.labelMedium!;
        break;
    }

    // Override işlemi
    style = style.copyWith(
      color: color ?? style.color,
      fontSize: fontSize ?? style.fontSize,
      fontWeight: fontWeight ?? style.fontWeight,
      letterSpacing: letterSpacing ?? style.letterSpacing,
      fontStyle: fontStyle ?? style.fontStyle,
      height: height ?? style.height,
    );

    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
