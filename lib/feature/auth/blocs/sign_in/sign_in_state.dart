import 'package:equatable/equatable.dart';

enum SignInStatus { initial, loading, success, failure }

class SignInState extends Equatable {
  final SignInStatus status;
  final String? errorMessage;

  const SignInState._({required this.status, this.errorMessage});

  const SignInState.initial() : this._(status: SignInStatus.initial);
  const SignInState.loading() : this._(status: SignInStatus.loading);
  const SignInState.success() : this._(status: SignInStatus.success);
  const SignInState.failure(String message)
    : this._(status: SignInStatus.failure, errorMessage: message);

  @override
  List<Object?> get props => [status, errorMessage];
}
