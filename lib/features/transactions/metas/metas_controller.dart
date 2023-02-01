import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../shared/injection.dart';
import '../../home/homelogin/homelogin_repository.dart';
import '../transactions_repository.dart';
import 'metas_model.dart';
import 'metas_repository.dart';
import 'metas_state.dart';

class MetasController {
  final HomeLoginRepository _loginRepository;
  final MetasRepository _metasRepository;
  MetasController(this._loginRepository, this._metasRepository);

  final _transactionsRepository = getIt.get<TransactionsRepository>();

  final notifier = ValueNotifier<MetaState>(MetasInitialState());

  CollectionReference metas = FirebaseFirestore.instance.collection('IdUser');

  MetaState get state => notifier.value;

  List<MetasModel> get resultAddMeta => [];

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

  Future<void> addMetas(String id, String goal, String objective, double value,
      double perfomance, DateTime date, String icon) async {
    notifier.value = MetasInitialState();
    try {
      final userId = _loginRepository.currentUser?.uid ?? '';
      final metasModel = MetasModel(
        id: id,
        goal: goal,
        objective: objective,
        value: value,
        date: date,
        idUser: userId,
        icon: icon,
      );

      if (await _metasRepository.addMetas(metasModel)) {
        notifier.value = MetasSuccessState(resultAddMeta);
      }
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

  Future<double> getBalanceSavings() async {
    
    double soma = 0.0;

    try {
      final savings = await _transactionsRepository.getBalanceSavings();
    
      for (var saving in savings) {
        soma = soma + saving.balance;
      }
      return soma;
    } catch (e) {
      return 0.0;
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
      notifier.value = MetasSuccessState(result);
    } catch (e) {
      notifier.value = MetasErrorState();
    }
  }

  Future<void> deleteMeta(String id) async {
    try {
      final result = await _metasRepository.deleteMeta(id);
      if (result) {
        final todoMetas = (state as MetasSuccessState).todoMetas;
        todoMetas.removeWhere((todo) => todo.id == id);
        notifier.value = MetasSuccessState(todoMetas);
      }
    } catch (e) {
      log("Registro não removido");
    }
  }
}
