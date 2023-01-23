import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homelogin/homelogin_state.dart';
import 'homelogin_repository.dart';

class HomeLoginController {
  final HomeLoginRepository _repository;
  HomeLoginController(this._repository);
  final notifier = ValueNotifier<HomeLoginState>(HomeLoginStateInitial());
  HomeLoginState get state => notifier.value;

  Future<void> login(String email, String password) async {
    notifier.value = HomeLoginStateLoading();
    try {
      await _repository.login(email, password);
      notifier.value = HomeLoginStateSuccess();
    } catch (e) {
      notifier.value = HomeLoginStateError();
    }
  }

  // Future<void> register(String email, String password) async {
  //   notifier.value = HomeLoginStateLoading();
  //   try {
  //     await Future.delayed(const Duration(seconds: 2));
  //     await _repository.register(email, password);
  //     notifier.value = HomeLoginStateSuccess();
  //   } catch (e, stackTrace) {
  //     notifier.value = HomeLoginStateError();
  //   }
  // }
}
