import 'package:flutter/material.dart';
import 'package:opero/product/constant/colors.dart';
import 'package:opero/product/constant/sizes.dart';

class OrDivider extends StatelessWidget {
  final String? text;
  final double thickness;
  final double indent;
  final double endIndent;

  const OrDivider({
    super.key,
    this.text,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      // Normal divider
      return Divider(
        color: AppColors.border(context),
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      );
    }

    // Divider with text (örneğin "OR")
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.border(context),
            thickness: thickness,
            endIndent: AppSizes.paddingSM,
          ),
        ),
        Text(
          text!,
          style: TextStyle(
            color: AppColors.textSecondary(context),
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.border(context),
            thickness: thickness,
            indent: AppSizes.paddingSM,
          ),
        ),
      ],
    );
  }
}
