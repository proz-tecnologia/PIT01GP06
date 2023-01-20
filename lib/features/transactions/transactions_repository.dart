import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_final_flutter/features/transactions/receitas/receitas_model.dart';
import 'package:projeto_final_flutter/features/transactions/transactions/transactions_model.dart';

class TransactionsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot<Map<String, dynamic>>> getBankAccountsSnapshot() {
    return _db
        .collection('IdUser')
        .doc(_uid)
        .collection('bankAccounts')
        .snapshots();
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getCardsSnapshot() {
    return _db
    .collection('IdUser')
    .doc(_uid)
    .collection('cards')
    .snapshots();
  }

    Future<DocumentReference<Map<String, dynamic>>> addTransacao(TransactionModel transacao){
    return _db.collection('IdUser')
    .doc(_uid)
    .collection("transacoes")
    .add(transacao.toMap());
  }




}
