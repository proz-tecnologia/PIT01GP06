import 'package:flutter/material.dart';
import 'homelogin_model.dart';
import 'homelogin_repository.dart';
import 'homelogin_state.dart';

class HomeLoginController extends ChangeNotifier {
  final HomeLoginRepository repository;
  HomeLoginController(this.repository);

  HomeLoginState _state = HomeLoginStateInitial();

  HomeLoginState get state => _state;

  List<User> _users = [];

  List<User> get users => _users;

  void updateState(HomeLoginState newState) {
    _state = newState;
    notifyListeners();
  }

  void createUser({
    required String loginId,
    required String email,
    required String pwd,
  }) async {
    updateState(HomeLoginStateLoading());
    try {
      final result = await repository.createUser(
        User(loginId: loginId, email: email, pwd: pwd),
      );
      if (result) {
        updateState(HomeLoginStateSuccess());
      } else {
        updateState(HomeLoginStateError());
      }
    } catch (e) {
      updateState(HomeLoginStateError());
    }
  }

  Future<void> getUsers() async {
    updateState(HomeLoginStateLoading());
    try {
      _users = await repository.getUsers();
      if (_users.isNotEmpty) {
        updateState(HomeLoginStateSuccess());
      } else {
        updateState(HomeLoginStateInitial());
      }
    } catch (e) {
      updateState(HomeLoginStateError());
    }
  }

  Future<void> getLogin(String email, String pwd) async {
    final mail = email;
    final senha = pwd;

    updateState(HomeLoginStateLoading());
    try {
      final login = await repository.getLogin(mail, senha);
      if (login == true) {
        updateState(HomeLoginStateSuccess());
      } else {
        updateState(HomeLoginStateInitial());
      }
    } catch (e) {
      updateState(HomeLoginStateError());
    }
  }
}
