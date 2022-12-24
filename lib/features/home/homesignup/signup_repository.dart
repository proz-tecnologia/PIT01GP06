import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup_model.dart';

abstract class SignupRepository {
  Future<SignupModel> register(String name, String email, String password);
}

class HomeSignupRepository implements SignupRepository {
  FirebaseAuth get _signupFirebase => FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<SignupModel> register(
      String name, String email, String password) async {
    try {
      await _signupFirebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) async {
       registerOnDatabase(value.user!.uid, name, email);
      });

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        user = _signupFirebase.currentUser;
        return SignupModel(
            name: user!.displayName ?? '', email: email, password: password);
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> registerOnDatabase(String uid, String nome, String email) async {
    await _db.collection('users').doc(uid).set({
      'uid': uid,
      'nome':nome,
      'email':email,
    });
  }
}
