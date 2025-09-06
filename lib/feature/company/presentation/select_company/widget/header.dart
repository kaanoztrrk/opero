import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../product/common/tile/header_tile.dart';
import '../../../../../product/utility/helpers.dart';
import '../../../../auth/blocs/authentication/authentication_bloc.dart';
import '../../../../auth/blocs/authentication/authentication_state.dart';

class SelectCompanyHeader extends StatelessWidget {
  const SelectCompanyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final user = state.localUser;
        return HeaderTile(
          showAvatar: false,
          title: user != null
              ? "Welcome, ${AppHelpers().getFirstName(user.name)}"
              : "Welcome",
          subtitle: "Select your company to continue",
        );
      },
    );
  }
}
