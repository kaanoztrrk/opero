import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/user_repository.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const SignUpState.initial()) {
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const SignUpState.loading());
    try {
      final userModel = await _userRepository.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
        // companyId, invitedBy, companyRole gibi opsiyonelleri de buraya gönderebilirsin
      );

      emit(SignUpState.success(userModel));
    } catch (e) {
      emit(SignUpState.failure(e.toString()));
    }
  }
}
