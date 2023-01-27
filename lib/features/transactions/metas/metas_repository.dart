// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/constant.dart';
import 'metas_model.dart';

abstract class MetasRepository {
  Future<bool> addMetas(MetasModel metasModel);
  Future<List<MetasModel>> getMetas(String userId);
  Future<List<MetasModel>> getIdMetas(String idMetas);
  Future<void> updateMetas(MetasModel todoMetas);

  Future<bool> deleteMeta(String userId);
}

class FirebaseMetasRepository implements MetasRepository {
  
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebase;
  
  FirebaseMetasRepository(this._firestore, this._firebase);
  

  @override
  Future<List<MetasModel>> getMetas(String userId) async {
    final result = await _firestore
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("goal", isEqualTo: 'meta')
        .get();
    final todoMetas = List<MetasModel>.from(
        result.docs.map((doc) => MetasModel.fromMap(doc.id, doc.data())));
    return todoMetas;
  }

  @override
  Future<List<MetasModel>> getIdMetas(String idMetas) async {

    final result = await _firestore
        .collection('IdUser')
        .doc(_firebase.currentUser!.uid)
        .collection('contas')
        .where("id", isEqualTo: idMetas)
        .get();
    final todoMeta = List<MetasModel>.from(
        result.docs.map((doc) => MetasModel.fromMap(doc.id, doc.data())));
    return todoMeta;
    
  }



  @override
  Future<bool> addMetas(MetasModel metasModel) async {
    try {
      final result = await _firestore
          .collection(db)
          .doc(_firebase.currentUser!.uid)
          .collection(accounts)
          .add(metasModel.toMap());
      return result.id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> updateMetas(MetasModel todoMetas) async {
    try {
      await _firestore
          .collection(db)
          .doc(_firebase.currentUser!.uid)
          .collection(accounts)
          .doc(todoMetas.id)
          .set(todoMetas.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteMeta(String todoId) async {
    try {
      final todo =
          _firestore.collection(db).doc(_firebase.currentUser!.uid).collection(accounts).doc(todoId);
      if (todo.id.isNotEmpty) {
        await todo
            .delete()
            .whenComplete(() => log("Registro deletado com sucesso!"));
      }
      return true;
    } catch (e, stackTrace) {
      log("Nao conseguiu deletar", error: e, stackTrace: stackTrace);
      return false;
    }
  }
}
