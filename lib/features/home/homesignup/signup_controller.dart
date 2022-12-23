import 'package:flutter/material.dart';
import 'signup_repository.dart';
import 'signup_state.dart';

class SignInController {
  final SignupRepository _repository;
  SignInController(this._repository);
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
}
