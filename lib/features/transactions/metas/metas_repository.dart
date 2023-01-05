import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'metas_model.dart';

abstract class MetasRepository {
  Future<bool> addMetas(MetasModel metasModel);
}

class FirebaseMetasRepository implements MetasRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> addMetas(MetasModel metasModel) async {
    try {
      final result = await _firestore
          .collection('iduser')
          .doc('xW0eG9pJNbAGEmQPHm1b')
          .collection('accounts')
          .add(metasModel.toMap());
      return result.id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}


 // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'objective': objective,
  //     'value': value,
  //     'date': date.millisecondsSinceEpoch,
  //     'idUser': idUser,
  //     'icon': icon,
  //     'perfomance': perfomance.map((x) => x.toMap()).toList(),
  //   };
  // }