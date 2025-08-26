import 'package:flutter/material.dart';
import 'package:opero/product/common/button/primary_button.dart';
import 'package:opero/product/common/tile/header_tile.dart';

import '../../../../product/constant/sizes.dart';

class CreateCompanyView extends StatelessWidget {
  const CreateCompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeaderTile(
              showAvatar: true,
              avatarRadius: AppSizes.iconXL * 1.5,
              avatarIcon: Icons.apartment,
              useTextField: true,
              textfieldHint: "Company Name",
              onEdit: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 140,
        padding: EdgeInsets.all(AppSizes.paddingMD),
        child: Column(
          children: [
            PrimaryButton(text: "Create", onPressed: () {}),
            SizedBox(height: AppSizes.paddingMD),
            Text(
              "By creating a company, you agree to our Terms of Service and Privacy Policy.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
