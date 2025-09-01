import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  /// Auth state değişimlerini dinler
  Stream<User?> get user => _firebaseAuth.authStateChanges();

  /// Kullanıcı oluşturma (sadece User tablosuna kayıt)
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      throw Exception("Failed to create user");
    }

    final userModel = UserModel(
      uid: firebaseUser.uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .set(userModel.toJson());

    return userModel;
  }

  /// Kullanıcı silme
  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).delete();
      await user.delete();
    }
  }

  /// Kullanıcıyı Firestore'dan al
  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromJson(doc.data()!);
  }

  /// Kullanıcıyı güncelle
  Future<void> updateUser(UserModel userModel) async {
    await _firestore
        .collection('users')
        .doc(userModel.uid)
        .update(userModel.toJson());
  }
}
