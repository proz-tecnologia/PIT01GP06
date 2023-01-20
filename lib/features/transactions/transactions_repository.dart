import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot<Map<String, dynamic>>> getBankAccountsSnapshot() {
    return _db
        .collection('Iduser')
        .doc(_uid)
        .collection('bankAccounts')
        .snapshots();
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getCardsSnapshot() {
    return _db
    .collection('Iduser')
    .doc(_uid)
    .collection('cards')
    .snapshots();
  }
}
