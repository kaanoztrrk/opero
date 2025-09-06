import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:opero/feature/auth/blocs/sign_in/sign_in_event.dart';
import '../../../../product/common/button/join_company_button.dart';
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
import '../../../auth/blocs/sign_in/sign_in_bloc.dart';
import '../../../auth/blocs/sign_in/sign_in_state.dart';
import '../../blocs/bloc/company_bloc.dart';
import '../../blocs/bloc/company_event.dart';
import '../../blocs/bloc/company_state.dart';
import 'mixin/select_company_mixin.dart';
import 'widget/header.dart';

class SelectCompanyView extends StatefulWidget {
  const SelectCompanyView({super.key});

  @override
  State<SelectCompanyView> createState() => _SelectCompanyViewState();
}

class _SelectCompanyViewState extends State<SelectCompanyView>
    with SelectCompanyMixin {
  int? _selectedIndex;
  @override
  void initState() {
    super.initState();

    // 🔹 authState üzerinden kullanıcıyı alıp şirketleri otomatik yükle
    final authState = context.read<AuthenticationBloc>().state;
    final user = authState.localUser;
    if (user != null) {
      context.read<CompanyBloc>().add(RefreshCompanies(user.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return RefreshIndicator(
          onRefresh: () async {
            final user = authState.localUser;
            if (user != null) {
              context.read<CompanyBloc>().add(RefreshCompanies(user.uid));
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state == const SignInState.initial()) {
                    // 🔹 Logout başarılı, SignInView'e yönlendir
                    context.go(AppRoutes.signInView);
                  }

                  if (state.status == SignInStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage ?? "Logout failed"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      Iconsax.logout,
                      color: AppColors.widgetColor(context),
                    ),
                    onPressed: () {
                      context.read<SignInBloc>().add(SignOutRequested());
                    },
                  );
                },
              ),
              backgroundColor: AppColors.background(context),
              elevation: 0,
            ),

            body: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingXL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* Header
                  SelectCompanyHeader(),
                  const SizedBox(height: AppSizes.paddingXXL),

                  //* Company List Title + Join Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text: "Your Companies",
                        type: AppTextType.titleMedium,
                      ),
                      JoinCompanyButton(),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMD),

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
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
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
                                padding: EdgeInsets.zero,
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
                                      padding: const EdgeInsets.all(
                                        AppSizes.spacingSM,
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
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              AppColors.widgetColor(context),
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
                        final companyState = context.read<CompanyBloc>().state;
                        if (companyState.status == CompanyStatus.success &&
                            _selectedIndex! < companyState.companies.length) {
                          final selectedCompany =
                              companyState.companies[_selectedIndex!];

                          // 🔹 DB’den çekmek için companyId gönder
                          context.read<CompanyBloc>().add(
                            GetCompanyById(selectedCompany.companyId),
                          );

                          // MainView'e companyId olarak gönder
                          context.go(
                            AppRoutes.mainView,
                            extra: {'companyId': selectedCompany.companyId},
                          );
                        }
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
          ),
        );
      },
    );
  }
}
