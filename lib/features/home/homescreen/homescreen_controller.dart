import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homescreen/screenmetas_state.dart';
import '../../transactions/metas/metas_model.dart';
import '../../transactions/metas/metas_repository.dart';
import '../../transactions/metas/metas_state.dart';
import '../../transactions/transactions_repository.dart';
import '../../wallets/bank_account/bank_account_model.dart';
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

  Future<void> getIdMetas(String id) async {
    try {
      final result = await _metasRepository.getIdMetas(id);
      notifier.value = MetasSuccessState(result);
    } catch (e) {
      notifier.value = MetasErrorState();
    }
  }

  Future<void> updateMetas(String id, String goal, String objective,
      double value, DateTime date, String icon, double perfomance) async {
    final userId = _loginRepository.currentUser?.uid ?? '';
    try {
      final todoMetasRequest = MetasModel(
        id: id,
        goal: 'meta',
        objective: objective,
        value: value,
        date: date,
        idUser: userId,
        icon: icon,
        perfomance: perfomance,
      );
      await _metasRepository.updateMetas(todoMetasRequest);
      final result = await _metasRepository.getMetas(id);
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

class BalanceRevenuesController {
  final TransactionsRepository _transactionsRepository;
  BalanceRevenuesController(this._transactionsRepository);

  final notifier = ValueNotifier<ScreenHomeState>(ScreenHomeInitialState());

  ScreenHomeState get stateScreen => notifier.value;

  Future<void> getBalanceRevenues() async {
    notifier.value = ScreenHomeInitialState();
    try {       
      final balances = await _transactionsRepository.getBalanceRevenues();
      print(balances);      


      double soma = 0.0;
      for (var balance in balances) {
        soma = soma + balance.balance;
      }
      print(soma);

      // for (var balance in balances){
      //   soma = soma + balance.balance;
      // }
      //ages.forEach((int age) => _addAndPrint(age));

      notifier.value = ScreenHomeSuccessState(soma);
    } catch (e) {
      notifier.value = ScreenHomeErrorState();
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
