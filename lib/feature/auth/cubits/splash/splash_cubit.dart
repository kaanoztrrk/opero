import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

enum SplashState { initial, loading, finished }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial);

  void startSplash() async {
    emit(SplashState.loading);

    // 3 saniye beklet
    await Future.delayed(const Duration(seconds: 2));

    emit(SplashState.finished);
  }
}
