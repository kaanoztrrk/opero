import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _firebaseAuth;

  SignInBloc({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      super(const SignInState.initial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(const SignInState.loading());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(const SignInState.success());
    } catch (e) {
      emit(SignInState.failure(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(const SignInState.loading());
    try {
      await _firebaseAuth.signOut();
      emit(const SignInState.initial());
    } catch (e) {
      emit(SignInState.failure(e.toString()));
    }
  }
}
