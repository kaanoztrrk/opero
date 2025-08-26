import 'package:equatable/equatable.dart';
import '../../data/models/user_model/user_model.dart';

enum SignUpStatus { initial, loading, success, failure }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String? errorMessage;
  final UserModel? user;

  const SignUpState._({required this.status, this.errorMessage, this.user});

  const SignUpState.initial() : this._(status: SignUpStatus.initial);
  const SignUpState.loading() : this._(status: SignUpStatus.loading);
  const SignUpState.success(UserModel user)
    : this._(status: SignUpStatus.success, user: user);
  const SignUpState.failure(String message)
    : this._(status: SignUpStatus.failure, errorMessage: message);

  @override
  List<Object?> get props => [status, errorMessage, user];
}
