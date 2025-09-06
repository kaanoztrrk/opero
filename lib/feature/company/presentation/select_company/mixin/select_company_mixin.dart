import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opero/feature/company/blocs/bloc/company_state.dart';

import '../../../blocs/bloc/company_bloc.dart';
import '../../../blocs/bloc/company_event.dart';

mixin SelectCompanyMixin<T extends StatefulWidget> on State<T> {
  bool _companiesLoaded = false;

  void loadUserCompanies(String userId) {
    if (!_companiesLoaded) {
      context.read<CompanyBloc>().add(GetUserCompanies(userId: userId));
      _companiesLoaded = true;
    }
  }

  void companyListener(BuildContext context, CompanyState state) {
    if (state.action == CompanyAction.getCompanyById &&
        state.status == CompanyStatus.success &&
        state.selectedCompany != null) {
      final company = state.selectedCompany!;
      print(
        "Selected Company Info: "
        "ID: ${company.companyId}, "
        "Name: ${company.name}, "
        "InviteCode: ${company.inviteCode}",
      );
    }
  }

  void resetCompaniesLoaded() => _companiesLoaded = false;
}
