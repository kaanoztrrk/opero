import 'package:flutter/material.dart';

import '../../../company/data/models/company_model/company_model.dart';

class DashboardView extends StatelessWidget {
  final CompanyModel? company;
  const DashboardView({super.key, this.company});

  @override
  Widget build(BuildContext context) {
    if (company == null) {
      return const Center(child: Text("No company selected"));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Company Name: ${company!.name}"),
          const SizedBox(height: 8),
          Text("Company ID: ${company!.companyId}"),
          const SizedBox(height: 8),
          Text("Invite Code: ${company!.inviteCode}"),
          const SizedBox(height: 8),
          Text("Created By: ${company!.createdBy}"),
          const SizedBox(height: 8),
          Text("Created At: ${company!.createdAt}"),
          const SizedBox(height: 8),
          Text("Updated At: ${company!.updatedAt}"),
          const SizedBox(height: 8),
          Text("Logo URL: ${company!.logoUrl ?? "No logo"}"),
          const SizedBox(height: 8),
          Text("Modules: ${company!.modules?.join(', ') ?? "No modules"}"),
          const SizedBox(height: 8),
          Text("Settings: ${company!.settings?.toString() ?? "No settings"}"),
        ],
      ),
    );
  }
}
