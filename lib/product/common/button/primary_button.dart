import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import '../text/text_widget.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double minHeight;
  final EdgeInsetsGeometry padding;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.minHeight = 50,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: fullWidth ? constraints.maxWidth : 0,
            minHeight: minHeight,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.buttonTextColor(context),
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 2,
            ),
            onPressed: onPressed,
            child: AppText(
              text: text,
              type: AppTextType.bodyLarge,
              fontWeight: FontWeight.w700,
              color: AppColors.buttonTextColor(context),
            ),
          ),
        );
      },
    );
  }
}
