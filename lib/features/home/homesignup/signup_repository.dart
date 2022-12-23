import 'package:firebase_auth/firebase_auth.dart';

import 'signup_model.dart';

abstract class SignupRepository {
  Future<SignupModel> register(String name, String email, String password);
}

class HomeSignupRepository implements SignupRepository {
  FirebaseAuth get _signupFirebase => FirebaseAuth.instance;

  Future updateDisplayName(user, text) async {
    await user.updateDisplayName(text);
  }

  @override
  Future<SignupModel> register(
      String? name, String email, String password) async {
    try {
      final result = await _signupFirebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await user?.updateDisplayName(name);
      await user?.reload();

      user = FirebaseAuth.instance.currentUser;
      updateDisplayName(user, name);

      if (user != null) {
        return SignupModel(
            name: user.displayName ?? '', email: email, password: password);
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
