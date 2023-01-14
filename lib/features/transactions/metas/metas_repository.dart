import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../shared/constant.dart';
import 'metas_model.dart';

abstract class MetasRepository {
  Future<bool> addMetas(MetasModel metasModel);
  Future<List<MetasModel>> getMetas(String userId);
  Future<bool> deleteMeta(String userId);
}

class FirebaseMetasRepository implements MetasRepository {
  final _firestore = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<List<MetasModel>> getMetas(String userId) async {
    final result = await _firestore
        .collection('IdUser')
        .doc(userId)
        .collection('contas')
        .where("goal", isEqualTo: 'meta')
        .get();
    final todoMetas = List<MetasModel>.from(
        result.docs.map((doc) => MetasModel.fromMap(doc.id, doc.data())));
    return todoMetas;
  }

  @override
  Future<bool> addMetas(MetasModel metasModel) async {
    try {
      final result = await _firestore
          .collection(db)
          .doc(_uid)
          .collection(accounts)
          .add(metasModel.toMap());
      return result.id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteMeta(String todoId) async {
    try {
      final todo =
          _firestore.collection(db).doc(_uid).collection(accounts).doc(todoId);
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
