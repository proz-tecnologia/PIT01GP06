import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../shared/constant.dart';
import 'metas_model.dart';

abstract class MetasRepository {
  Future<bool> addMetas(MetasModel metasModel);
}

class FirebaseMetasRepository implements MetasRepository {
  final _firestore = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;
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
}
