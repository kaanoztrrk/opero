import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../utility/bottom_sheet/bottom_sheet.dart';
import '../field/primary_textfield.dart';
import '../text/text_widget.dart';
import 'primary_button.dart';

class JoinCompanyButton extends StatelessWidget {
  const JoinCompanyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppBottomSheet(context).show(
          title: const PrimaryTextField(hint: "Enter Code"),
          content: PrimaryButton(text: "Join", onPressed: () {}),
        );
      },
      child: const AppText(
        text: "Join",
        type: AppTextType.bodyLarge,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
