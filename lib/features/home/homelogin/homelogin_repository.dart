import 'package:firebase_auth/firebase_auth.dart';

import 'homelogin_model.dart';

abstract class HomeLoginRepository {
  Future<UserModel> login(String email, String password);
  Future<void> signOut();
  bool get isLogged;
  User? get currentUser;
}

class FirebaseRepository implements HomeLoginRepository {
  FirebaseAuth get _firebase => FirebaseAuth.instance;

  @override
  bool get isLogged => _firebase.currentUser != null;

  @override
  User? get currentUser => _firebase.currentUser;

  @override
  Future<void> signOut() async {
    await _firebase.signOut();
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final result = await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return UserModel(name: '', email: email);
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
