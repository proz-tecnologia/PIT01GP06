import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/constant.dart';

class TransactionsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot<Map<String, dynamic>>> getBankAccountsSnapshot() {
    return _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Conta')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCardsSnapshot() {
    return _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Cartão')
        .snapshots();
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
}
