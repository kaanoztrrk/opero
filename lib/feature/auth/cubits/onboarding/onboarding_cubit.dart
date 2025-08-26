// onboarding_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void setPage(int index) => emit(index);

  void next(int total) {
    if (state < total - 1) emit(state + 1);
  }

  void previous() {
    if (state > 0) emit(state - 1);
  }

  void skipToEnd(int total) => emit(total - 1);
}
