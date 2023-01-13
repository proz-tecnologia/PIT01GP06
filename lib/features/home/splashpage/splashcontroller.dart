import 'package:flutter/material.dart';
import '../homelogin/homelogin_repository.dart';

enum SplashState { loading, authenticated, unauthenticated }

class SplashController {
  final HomeLoginRepository _repository;
  SplashController(this._repository);

  final notifier = ValueNotifier<SplashState>(SplashState.loading);
  SplashState get state => notifier.value;

  Future<void> isAuthenticated() async {
    await Future.delayed(const Duration(seconds: 3));

    if (_repository.isLogged) {
      notifier.value = SplashState.authenticated;
    } else {
      notifier.value = SplashState.unauthenticated;
    }
  }
}
