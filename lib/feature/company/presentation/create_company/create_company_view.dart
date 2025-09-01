import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/blocs/authentication/authentication_bloc.dart';
import '../../../auth/blocs/authentication/authentication_state.dart';
import '../../../auth/data/models/user_model/user_model.dart';
import '../../blocs/bloc/company_bloc.dart';
import '../../blocs/bloc/company_event.dart';
import '../../blocs/bloc/company_state.dart';

class CreateCompanyView extends StatefulWidget {
  const CreateCompanyView({super.key});

  @override
  State<CreateCompanyView> createState() => _CreateCompanyViewState();
}

class _CreateCompanyViewState extends State<CreateCompanyView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state.status == CompanyStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Company created successfully!')),
          );
          Navigator.pop(context);
        } else if (state.status == CompanyStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Failed to create company'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Create Company")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: "Company Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                state.status == CompanyStatus.loading
                    ? const CircularProgressIndicator()
                    : BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, userState) {
                          final UserModel? user = userState.localUser;
                          return ElevatedButton(
                            onPressed: () {
                              if (user == null) return;

                              final companyName = _controller.text.trim();
                              if (companyName.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Company name cannot be empty',
                                    ),
                                  ),
                                );
                                return;
                              }

                              context.read<CompanyBloc>().add(
                                CreateCompany(
                                  name: companyName,
                                  ownerId: user.uid,
                                ),
                              );
                            },
                            child: const Text("Create Company"),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
