import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_final_flutter/features/transactions/receitas/receitas_model.dart';

import '../../../shared/constant.dart';
import '../../wallets/bank_account/bank_account_model.dart';

class ReceitasRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addReceita(ReceitasModel receitasModel) async {
    //adiciona receita à coleccion
    _db
        .collection(db)
        .doc(_uid)
        .collection(transactions)
        .add(receitasModel.toMap());

    ///procedimento - adicionar receita à conta bancária
    //verifica o id da conta bancária
    final result = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Conta')
        .where("nomeConta", isEqualTo: receitasModel.conta)
        .get();
    final idBank = List<BankAccountModel>.from(
        result.docs.map((doc) => BankAccountModel.fromMap(doc.id, doc.data())));
    
    //soma o valor da transação ao saldo da conta bancária
    _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .doc(idBank[0].id)
        .update({'balance': idBank[0].balance + receitasModel.valor}).then(
            (value) => log("DocumentSnapshot successfully updated!"),
            onError: (e) => log("Error updating document $e"));

    ///atualizacão acumulado do saldo balance receita por tipo de receita
    //consulta para verificar o id da receita
    final updateBalance = await _db
        .collection(db)
        .doc(_uid)
        .collection(transactions)
        .where("categoria", isEqualTo: receitasModel.categoria)
        .orderBy('dateReg', descending: true)
        .limit(1)
        .get();

    final idReceita = List<ReceitasModel>.from(updateBalance.docs
        .map((doc) => ReceitasModel.fromMap(doc.id, doc.data())));
    
    //atualiza o balance da receita por categoria
    _db
        .collection(db)
        .doc(_uid)
        .collection(transactions)
        .doc(idReceita[0].id)
        .update({'balance': idReceita[0].balance + receitasModel.valor}).then(
            (value) => log("DocumentSnapshot successfully updated!"),
            onError: (e) => log("Error updating document $e"));
  }
}
