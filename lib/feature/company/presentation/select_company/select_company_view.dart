import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../product/common/button/primary_button.dart';
import '../../../../product/common/field/primary_textfield.dart';
import '../../../../product/common/text/text_widget.dart';
import '../../../../product/common/tile/header_tile.dart';
import '../../../../product/constant/colors.dart';
import '../../../../product/constant/sizes.dart';
import '../../../../product/routes/route.dart';
import '../../../../product/utility/bottom_sheet/bottom_sheet.dart';
import '../../../../product/utility/helpers.dart';
import '../../../auth/blocs/authentication/authentication_bloc.dart';
import '../../../auth/blocs/authentication/authentication_state.dart';
import '../../blocs/bloc/company_bloc.dart';
import '../../blocs/bloc/company_state.dart';
import 'mixin/select_company_mixin.dart';

class SelectCompanyView extends StatefulWidget {
  const SelectCompanyView({super.key});

  @override
  State<SelectCompanyView> createState() => _SelectCompanyViewState();
}

class _SelectCompanyViewState extends State<SelectCompanyView>
    with SelectCompanyMixin {
  int? _selectedIndex; // Seçili tile index'i

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Header
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                final user = state.localUser;
                return HeaderTile(
                  title: user != null
                      ? "Welcome, ${AppHelpers().getFirstName(user.name)}"
                      : "Welcome",
                  subtitle: "Select your company to continue",
                );
              },
            ),
            const SizedBox(height: AppSizes.paddingXXL),

            //* Company List Title + Join Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  text: "Your Companies",
                  type: AppTextType.titleMedium,
                ),
                InkWell(
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
                ),
              ],
            ),

            //* Company List
            Expanded(
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, authState) {
                  final user = authState.localUser;

                  if (user == null) {
                    return const Center(
                      child: AppText(
                        text: "Lütfen giriş yapın",
                        type: AppTextType.bodyLarge,
                      ),
                    );
                  }

                  loadUserCompanies(user.uid);

                  return BlocConsumer<CompanyBloc, CompanyState>(
                    listener: companyListener,
                    builder: (context, state) {
                      if (state.status == CompanyStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == CompanyStatus.success) {
                        if (state.companies.isEmpty) {
                          return const Center(
                            child: AppText(
                              text: 'Hiç şirket bulunamadı',
                              type: AppTextType.bodyLarge,
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: state.companies.length,
                          itemBuilder: (context, index) {
                            final company = state.companies[index];
                            final isSelected = _selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: AppSizes.paddingXS,
                                ),
                                padding: const EdgeInsets.all(
                                  AppSizes.paddingMD,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.card(context),
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.radiusMD,
                                  ),
                                  border: isSelected
                                      ? Border.all(
                                          color: AppColors.primary,
                                          width: 2,
                                        )
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.widgetColor(
                                      context,
                                    ),
                                    child: AppText(
                                      text: company.name.isNotEmpty
                                          ? company.name[0].toUpperCase()
                                          : '?',
                                      type: AppTextType.titleMedium,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: AppText(
                                    text: company.name,
                                    type: AppTextType.titleSmall,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: AppSizes.paddingLG),

            //* Join & Create Buttons
            PrimaryButton(
              text: "Join Company",
              onPressed: () {
                if (_selectedIndex != null) {
                  final selectedCompany = context
                      .read<CompanyBloc>()
                      .state
                      .companies[_selectedIndex!];
                  print("Selected Company: ${selectedCompany.name}");
                } else {
                  print("No company selected");
                }
              },
            ),
            const SizedBox(height: AppSizes.paddingMD),
            InkWell(
              onTap: () {
                context.push(AppRoutes.createCompanyView);
              },
              child: const AppText(
                text: "Create Company",
                type: AppTextType.bodyMedium,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.paddingMD),
          ],
        ),
      ),
    );
  }
}
