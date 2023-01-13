import 'dart:developer';
import 'package:flutter/material.dart';
import '../../transactions/metas/metas_repository.dart';
import '../../transactions/metas/metas_state.dart';
import '../homelogin/homelogin_repository.dart';

class MetaScreenController {
  final HomeLoginRepository _loginRepository;
  final MetasRepository _metasRepository;
  MetaScreenController(this._loginRepository, this._metasRepository);
  final notifier = ValueNotifier<MetaState>(MetasInitialState());

  MetaState get stateScreen => notifier.value;

  Future<void> getMetas() async {
    notifier.value = MetasInitialState();
    try {
      final userId = _loginRepository.currentUser?.uid ?? '';
      final result = await _metasRepository.getMetas(userId);
      notifier.value = MetasSuccessState(result);
    } catch (e) {
      notifier.value = MetasErrorState();
    }
  }

  Future<void> deleteMeta(String id) async {
    try {
      final result = await _metasRepository.deleteMeta(id);
      if (result) {
        final todoMetas = (stateScreen as MetasSuccessState).todoMetas;
        todoMetas.removeWhere((todo) => todo.id == id);
        notifier.value = MetasSuccessState(todoMetas);
      }
    } catch (e) {
      log("Registro não removido");
    }
  }
}

String getCurrentMonth() {
  return 'Novembro';
}

String getNextMonth() {
  return 'Dezembro';
}

String getPreviousMonth() {
  return 'Outubro';
}

void showPreviousWallet() {}

void showNextWallet() {}

void deleteWallet() {}

void editWallet() {}

void showPreviousGoal() {}

void showNextGoal() {}

void deleteGoal() {}

void editGoal() {}

void addExpense() {}

void addRevenue() {}
