import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_final_flutter/features/transactions/receitas/receitas_model.dart';

class ReceitasRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Future<DocumentReference<Map<String, dynamic>>> addReceita(ReceitasModel despesa){
    return _db.collection('users')
    .doc(_uid)
    .collection("receitas")
    .add(despesa.toMap());
  }
}