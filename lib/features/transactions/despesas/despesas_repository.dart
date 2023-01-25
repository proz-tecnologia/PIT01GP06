import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import '../../../shared/constant.dart';
import '../../wallets/bank_account/bank_account_model.dart';
import '../../wallets/card/card_model.dart';
import 'despesas_model.dart';

class DespesasRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addDespesa(DespesasModel despesa) async {
    //adiciona a despesa
    _db.collection(db).doc(_uid).collection(transactions).add(despesa.toMap());

    //verifica a Conta associada à despesa e atualiza o saldo balance
    if (despesa.typeconta == 'Conta') {
      final result = await _db
          .collection(db)
          .doc(_uid)
          .collection(accounts)
          .where("typeconta", isEqualTo: despesa.typeconta)
          .where("nomeConta", isEqualTo: despesa.conta)
          .get();
      final idBank = List<BankAccountModel>.from(result.docs
          .map((doc) => BankAccountModel.fromMap(doc.id, doc.data())));

      _db
          .collection(db)
          .doc(_uid)
          .collection(accounts)
          .doc(idBank[0].id)
          .update({'balance': idBank[0].balance - despesa.valor}).then(
              (value) => log("DocumentSnapshot successfully updated!"),
              onError: (e) => log("Error updating document $e"));
    }

    //verifica qual conta Cartão associada à despesa e atualiza o saldo balance
    if (despesa.typeconta == 'Cartão') {
      final result = await _db
          .collection(db)
          .doc(_uid)
          .collection(accounts)
          .where("typeconta", isEqualTo: despesa.typeconta)
          .where("nomeCartao", isEqualTo: despesa.conta)
          .get();
          
      final idCard = List<CardModel>.from(
          result.docs.map((doc) => CardModel.fromMap(doc.id, doc.data())));

      _db
          .collection(db)
          .doc(_uid)
          .collection(accounts)
          .doc(idCard[0].id)
          .update({'balance': idCard[0].balance + despesa.valor}).then(
              (value) => log("DocumentSnapshot successfully updated!"),
              onError: (e) => log("Error updating document $e"));
    }
  }

  Future<List<DespesasModel>> getDespesaCategoria(String categoria) async {
    final result = await _db
        .collection(db)
        .doc(_uid)
        .collection(transactions)
        .where("categoria", isEqualTo: categoria)
        .orderBy('timeReg', descending: true)
        .limit(1)
        .get();

    final todoDespesa = List<DespesasModel>.from(
        result.docs.map((doc) => DespesasModel.fromMap(doc.id, doc.data())));
    return todoDespesa;
  }
}
