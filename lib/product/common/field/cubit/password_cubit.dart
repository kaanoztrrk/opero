import 'package:bloc/bloc.dart';

class PasswordCubit extends Cubit<bool> {
  PasswordCubit() : super(true); // Başlangıçta şifre gizli

  void toggleVisibility() => emit(!state);
}
