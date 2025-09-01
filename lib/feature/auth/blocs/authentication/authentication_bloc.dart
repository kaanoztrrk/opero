import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model/user_model.dart';
import '../../data/repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required this.userRepository})
    : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });

    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<DeleteUser>(_onDeleteUser);
    on<ChangePassword>(_onChangePassword);
  }

  void _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event.user != null) {
      final box = Hive.box<UserModel>('userBox');
      UserModel? localUser;

      if (box.isNotEmpty) {
        // Hive'dan çek
        localUser = box.getAt(0);
      } else {
        try {
          // Firebase Firestore'dan çek
          final doc = await FirebaseFirestore.instance
              .collection('users')
              .doc(event.user!.uid)
              .get();

          if (doc.exists && doc.data() != null) {
            // Firestore verisini UserModel'a parse et
            localUser = UserModel.fromJson(doc.data()!);

            // Hive'a kaydet
            await box.add(localUser);
          }
        } catch (e) {
          print('Firebase user fetch error: $e');
        }
      }

      emit(
        AuthenticationState.authenticated(event.user!, localUser: localUser),
      );
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<void> _onDeleteUser(
    DeleteUser event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.deleting());
    try {
      final uid = event.userId;
      await userRepository.deleteUser();
      final storage = FirebaseStorage.instance;
      final imageRef = storage.ref().child('profile_images/$uid');
      final ListResult result = await imageRef.listAll();
      for (var item in result.items) {
        await item.delete(); // Her bir resmi sil
      }

      // 4. Hive veritabanındaki kullanıcı verilerini sil
      await Hive.deleteFromDisk();

      // 5. SharedPreferences'taki tüm verileri temizle
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      SystemNavigator.pop();
    } catch (e) {
      emit(AuthenticationState.error(e.toString()));
    }
  }

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.deleting());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(const AuthenticationState.unauthenticated());
        return;
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: event.oldPassword,
      );

      // Re-authenticate user
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(event.newPassword);

      emit(AuthenticationState.authenticated(user));
    } catch (e) {
      emit(AuthenticationState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
