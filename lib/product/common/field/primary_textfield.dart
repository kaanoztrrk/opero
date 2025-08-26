import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opero/product/common/text/text_widget.dart';
import 'package:opero/product/constant/colors.dart';
import 'package:opero/product/constant/sizes.dart';
import 'cubit/password_cubit.dart'; // Cubit import

class PrimaryTextField extends StatelessWidget {
  final String hint;
  final String? title;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool isPasswordField; // 🔹 yeni parametre

  const PrimaryTextField({
    super.key,
    required this.hint,
    this.title,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
    this.validator,
    this.isPasswordField = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    if (isPasswordField) {
      return BlocProvider(
        create: (_) => PasswordCubit(),
        child: _PasswordTextField(
          hint: hint,
          title: title,
          controller: controller,
          keyboardType: keyboardType,
          prefixIcon: prefixIcon,
          onChanged: onChanged,
          validator: validator,
        ),
      );
    }

    // Normal TextField
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          AppText(
            text: title!,
            type: AppTextType.bodyLarge,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppSizes.paddingXS),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMD,
              vertical: AppSizes.paddingSM,
            ),
            filled: true,
            fillColor: AppColors.background(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              borderSide: BorderSide.none,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.primary)
                : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixTap,
                    child: Icon(suffixIcon, color: AppColors.primary),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  final String hint;
  final String? title;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const _PasswordTextField({
    super.key,
    required this.hint,
    this.title,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          AppText(
            text: title!,
            type: AppTextType.bodyLarge,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppSizes.paddingXS),
        ],
        BlocBuilder<PasswordCubit, bool>(
          builder: (context, obscureText) {
            return TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMD,
                  vertical: AppSizes.paddingSM,
                ),
                filled: true,
                fillColor: AppColors.background(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: prefixIcon != null
                    ? Icon(prefixIcon, color: AppColors.primary)
                    : null,
                suffixIcon: GestureDetector(
                  onTap: () => context.read<PasswordCubit>().toggleVisibility(),
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
