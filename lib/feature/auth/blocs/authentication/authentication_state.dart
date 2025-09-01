// authentication_state.dart
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/user_model/user_model.dart'; // Hive modelini import et

class AuthenticationState extends Equatable {
  final User? user; // Firebase User
  final UserModel? localUser; // Hive UserModel
  final AuthenticationStatus status;
  final String? errorMessage;

  const AuthenticationState._({
    this.user,
    this.localUser,
    this.errorMessage,
    required this.status,
  });

  const AuthenticationState.unknown()
    : this._(status: AuthenticationStatus.unknown);

  const AuthenticationState.authenticated(User user, {UserModel? localUser})
    : this._(
        status: AuthenticationStatus.authenticated,
        user: user,
        localUser: localUser,
      );

  const AuthenticationState.unauthenticated()
    : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.deleting()
    : this._(status: AuthenticationStatus.deleting);

  const AuthenticationState.changingPassword()
    : this._(status: AuthenticationStatus.changingPassword);

  const AuthenticationState.error(String message)
    : this._(status: AuthenticationStatus.error, errorMessage: message);

  @override
  List<Object?> get props => [user, localUser, status, errorMessage];
}

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  deleting,
  changingPassword,
  error,
}
