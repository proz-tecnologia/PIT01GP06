import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'despesas_model.dart';

class DespesasRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;



  Stream<QuerySnapshot<Map<String, dynamic>>> getBankAccountsSnapshot(){
     return _db.collection('users').doc(_uid).collection('bankAccounts').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCardsSnapshot(){
    return _db.collection('users').doc(_uid).collection('cards').snapshots();
  }

  addDespesa(DespesasModel despesa){
    _db.collection('users')
    .doc(_uid)
    .collection("despesas")
    .add(despesa.toMap());
  }




}