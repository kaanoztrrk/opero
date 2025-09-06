import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:opero/feature/auth/cubits/forgot_password/forgot_password.dart';
import 'package:opero/feature/auth/cubits/onboarding/onboarding_cubit.dart';
import 'package:opero/feature/company/blocs/bloc/company_bloc.dart';
import 'package:opero/feature/company/data/repository/company_repository.dart';
import 'package:opero/feature/home/cubits/main/main_cube.dart';
import '../../../feature/auth/blocs/authentication/authentication_bloc.dart';
import '../../../feature/auth/blocs/sign_in/sign_in_bloc.dart';
import '../../../feature/auth/blocs/sign_up/sign_up_bloc.dart';
import '../../../feature/auth/cubits/splash/splash_cubit.dart';
import '../../../feature/auth/data/repository/user_repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Firebase singletons
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  getIt.registerLazySingleton<CompanyRepository>(
    () => CompanyRepository(firestore: getIt<FirebaseFirestore>()),
  );

  // UserRepository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  // AuthenticationBloc
  getIt.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(userRepository: getIt<UserRepository>()),
  );

  // SignInBloc
  getIt.registerFactory<SignInBloc>(
    () => SignInBloc(firebaseAuth: getIt<FirebaseAuth>()),
  );

  // SignUpBloc
  getIt.registerFactory<SignUpBloc>(
    () => SignUpBloc(userRepository: getIt<UserRepository>()),
  );

  // CompanyBloc
  getIt.registerFactory<CompanyBloc>(
    () => CompanyBloc(repository: getIt<CompanyRepository>()),
  );

  // Cubits
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
  getIt.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit());
  getIt.registerFactory<MainCubit>(() => MainCubit());
}
