import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup_repository.dart';
import 'signup_state.dart';

class SignUpController {
  final SignupRepository _repository;
  SignUpController(this._repository);
  final notifier = ValueNotifier<SignupState>(SignupStateInitial());
  SignupState get state => notifier.value;

  Future<void> register(String name, String email, String password) async {
    notifier.value = SignupStateLoading();
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _repository.register(name, email, password);
      notifier.value = SignupStateSuccess();
    } catch (e) {
      notifier.value = SignupStateError();
    }
  }

  static String getUserName() {
    final auth = FirebaseAuth.instance;
    return auth.currentUser!.displayName!;
  }
}
