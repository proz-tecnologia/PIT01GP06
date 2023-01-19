import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../home/homelogin/homelogin_repository.dart';
import 'metas_model.dart';
import 'metas_repository.dart';
import 'metas_state.dart';

class MetasController {
  final HomeLoginRepository _loginRepository;
  final MetasRepository _metasRepository;
  MetasController(this._loginRepository, this._metasRepository);
  final notifier = ValueNotifier<MetaState>(MetasInitialState());

  CollectionReference metas = FirebaseFirestore.instance.collection('IdUser');

  MetaState get state => notifier.value;

  List<MetasModel> get resultAddMeta => [];

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
          perfomance: perfomance);

      if (await _metasRepository.addMetas(metasModel)) {
        notifier.value = MetasSuccessState(resultAddMeta);
      }
    } catch (e) {
      notifier.value = MetasErrorState();
    }
  }
  
}
