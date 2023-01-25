import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_final_flutter/features/transactions/transactions/transactions_model.dart';

import '../../shared/constant.dart';

class TransactionsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Future<List<String>> getListBankAccountsSnapshot() async {
    List<String> bankAccounts = [];

    final querySnapshot = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Conta')
        .get();

      querySnapshot.docs.forEach((doc) {
        bankAccounts.add(doc['nomeConta']);
      });

      return bankAccounts;
  }

  Future<List<String>> getListCardsSnapshot() async {
    List<String> cards = [];

    final querySnapshot = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Cartão')
        .get();

      querySnapshot.docs.forEach((doc) {
        cards.add(doc['nomeCartao']);
      });

      return cards;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getDespesaSaldo(
      String categoria) {
    return _db
        .collection(db)
        .doc(_uid)
        .collection(transactions)
        .where("categoria", isEqualTo: categoria)
        .orderBy('data')
        .limit(1)
        .snapshots();
  }

    Future<DocumentReference<Map<String, dynamic>>> addTransacao(TransactionModel transacao){
    return _db.collection('IdUser')
    .doc(_uid)
    .collection("transacoes")
    .add(transacao.toMap());
  }




}
