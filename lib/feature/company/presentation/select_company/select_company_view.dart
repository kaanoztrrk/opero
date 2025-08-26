import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:opero/product/common/button/primary_button.dart';
import 'package:opero/product/common/field/primary_textfield.dart';
import 'package:opero/product/common/text/text_widget.dart';
import 'package:opero/product/common/tile/header_tile.dart';
import 'package:opero/product/constant/colors.dart';
import 'package:opero/product/constant/sizes.dart';
import 'package:opero/product/routes/route.dart';
import 'package:opero/product/utility/bottom_sheet/bottom_sheet.dart';

class SelectCompanyView extends StatelessWidget {
  const SelectCompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Header Tile
            HeaderTile(
              showAvatar: true,
              title: 'Hi, John Doe',
              subtitle:
                  'Please select a company from the list below to continue using the app and access your personalized workspace.',
              subtitleType: AppTextType.bodyLarge,
            ),
            SizedBox(height: AppSizes.paddingXXL),
            //* Company List title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: "Your Company's", type: AppTextType.titleMedium),
                InkWell(
                  onTap: () {
                    AppBottomSheet(context).show(
                      title: PrimaryTextField(hint: "Enter Code"),
                      content: PrimaryButton(text: "Join", onPressed: () {}),
                    );
                  },
                  child: AppText(
                    text: "Join",
                    type: AppTextType.bodyLarge,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            //* Company List
            Container(
              width: double.infinity,
              height: 300,
              margin: const EdgeInsets.symmetric(vertical: AppSizes.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.01),
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.paddingLG),
            //* Join Button
            PrimaryButton(text: "Join Company", onPressed: () {}),
            //* Create Button
            SizedBox(height: AppSizes.paddingMD),
            InkWell(
              onTap: () {
                context.push(AppRoutes.createCompanyView);
              },
              child: AppText(
                text: "Create Company",
                type: AppTextType.bodyMedium,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
