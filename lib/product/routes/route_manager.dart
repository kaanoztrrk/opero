import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:opero/feature/auth/blocs/authentication/authentication_bloc.dart';
import 'package:opero/feature/auth/blocs/sign_up/sign_up_bloc.dart';
import 'package:opero/feature/auth/cubits/forgot_password/forgot_password.dart';
import 'package:opero/feature/auth/cubits/onboarding/onboarding_cubit.dart';
import 'package:opero/feature/auth/presentation/forgot_password/forgot_password_view.dart';
import 'package:opero/feature/auth/presentation/onboarding/onboarding_view.dart';
import 'package:opero/feature/auth/presentation/sign_in/sign_in_view.dart';
import 'package:opero/feature/company/presentation/create_company/create_company_view.dart';
import 'package:opero/feature/home/presentation/main_view/main_view.dart';
import 'package:opero/product/init/di/di.dart';
import 'package:opero/product/routes/route.dart';

import '../../feature/auth/presentation/sign_up/sign_up_view.dart';
import '../../feature/auth/presentation/splash/splash_view.dart';
import '../../feature/company/presentation/select_company/select_company_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// GoRouter configuration that contains all app routes.
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: AppRoutes.splashView,
      builder: (BuildContext context, GoRouterState state) {
        return SplashView();
      },
    ),
    GoRoute(
      path: AppRoutes.onBoardingView,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: getIt<AuthenticationBloc>()),
            BlocProvider.value(value: getIt<OnboardingCubit>()),
          ],
          child: OnboardingView(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.forgotPasswordView,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [BlocProvider.value(value: getIt<ForgotPasswordCubit>())],
          child: ForgotPasswordView(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.signInView,
      builder: (BuildContext context, GoRouterState state) {
        return SignInView();
      },
    ),
    GoRoute(
      path: AppRoutes.signUpView,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [BlocProvider.value(value: getIt<SignUpBloc>())],
          child: SignUpView(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.selectCompanyView,
      builder: (BuildContext context, GoRouterState state) {
        return SelectCompanyView();
      },
    ),
    GoRoute(
      path: AppRoutes.createCompanyView,
      builder: (BuildContext context, GoRouterState state) {
        return CreateCompanyView();
      },
    ),
    GoRoute(
      path: AppRoutes.mainView,
      builder: (BuildContext context, GoRouterState state) {
        return MainView();
      },
    ),
  ],
);
