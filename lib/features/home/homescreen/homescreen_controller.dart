import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homescreen/screenmetas_state.dart';
import '../../../shared/classes.dart';
import '../../transactions/metas/metas_model.dart';
import '../../transactions/metas/metas_repository.dart';
import '../../transactions/transactions_repository.dart';
import '../homelogin/homelogin_repository.dart';

class MetaScreenController {
  final HomeLoginRepository _loginRepository;
  final MetasRepository _metasRepository;
  MetaScreenController(this._loginRepository, this._metasRepository);
  final notifier = ValueNotifier<ScreenMetaState>(ScreenMetaInitialState());

  ScreenMetaState get stateScreen => notifier.value;

  Future<void> getMetas() async {
    notifier.value = ScreenMetaInitialState();
    try {
      final userId = _loginRepository.currentUser?.uid ?? '';
      final result = await _metasRepository.getMetas(userId);
      notifier.value = ScreenMetaSuccessState(result);
    } catch (e) {
      notifier.value = ScreenMetaErrorState();
    }
  }

  Future<void> getIdMetas(String id) async {
    try {
      final result = await _metasRepository.getIdMetas(id);
      notifier.value = ScreenMetaSuccessState(result);
    } catch (e) {
      notifier.value = ScreenMetaErrorState();
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
      );
      await _metasRepository.updateMetas(todoMetasRequest);
      final result = await _metasRepository.getMetas(id);
      notifier.value = ScreenMetaSuccessState(result);
    } catch (e) {
      notifier.value = ScreenMetaErrorState();
    }
  }

  Future<void> deleteMeta(String id) async {
    try {
      final result = await _metasRepository.deleteMeta(id);
      if (result) {
        final todoMetas = (stateScreen as ScreenMetaSuccessState).todoMetas;
        todoMetas.removeWhere((todo) => todo.id == id);
        notifier.value = ScreenMetaSuccessState(todoMetas);
      }
    } catch (e) {
      log("Registro não removido");
    }
  }
}

class BalanceController {
  final TransactionsRepository _transactionsRepository;
  BalanceController(this._transactionsRepository);

  final notifierRevenues =
      ValueNotifier<ScreenGlobalState>(ScreenGlobalInitialState());

  final notifierBalance =
      ValueNotifier<ScreenBalanceState>(ScreenBalanceInitialState());

  final notifierWallet =
      ValueNotifier<ScreenWalletState>(ScreenWalletInitialState());

  ScreenGlobalState get stateRevenues => notifierRevenues.value;
  ScreenBalanceState get stateBalance => notifierBalance.value;
  ScreenWalletState get stateWallet => notifierWallet.value;

  Future<void> getBalanceRevenues() async {
    try {
      final balances = await _transactionsRepository.getBalanceRevenues();
      double soma = 0.0;
      for (var balance in balances) {
        soma = soma + balance.balance;
      }
      notifierRevenues.value = ScreenGlobalSuccessState(soma);
    } catch (e) {
      notifierRevenues.value = ScreenGlobalErrorState();
    }
  }  

  Future<void> getListWallet() async {
    List<Wallet> listCarteira = [];
    try {
      List<Map<String, dynamic>>? listWallet =
          await _transactionsRepository.getListWallet();

      listWallet?.forEach((listWallet) {
        if (listWallet['typeconta'] == 'Cartão') {
          listCarteira.add(Wallet(
              id: listWallet['id'],
              type: listWallet['typeconta'],
              name: listWallet['nomeCartao'],
              institution: listWallet['bandeiraCartao'],
              balance: listWallet['balance']));
        } else if (listWallet['typeconta'] == 'Conta') {
          listCarteira.add(Wallet(
              id: listWallet['id'],
              type: listWallet['typeconta'],
              name: listWallet['nomeConta'],
              institution: listWallet['tipoConta'],
              balance: listWallet['balance']));
        }
      });
      notifierWallet.value = ScreenWalletSuccessState(listCarteira);      
    } catch (e) {
      notifierWallet.value = ScreenWalletErrorState();
    }
  }

  Future<void> controllerData(int botton, int dia, int mes, int ano) async {
    try {
      if (botton == 0) {
        final controleWidget =
            await _transactionsRepository.getBalanceUser(mes, ano);
        notifierBalance.value = ScreenBalanceSuccessState(controleWidget);
      } else if (botton == 1) {
        //Controle para frente
        final controleWidget =
            await _transactionsRepository.getBalanceUser(mes, ano);
        notifierBalance.value = ScreenBalanceSuccessState(controleWidget);
      } else if (botton == 2) {
        //Controle para trás
        final controleWidget =
            await _transactionsRepository.getBalanceUser(mes, ano);
        notifierBalance.value = ScreenBalanceSuccessState(controleWidget);
      }
    } catch (e) {
      notifierBalance.value = ScreenBalanceErrorState();
    }
  }
}
