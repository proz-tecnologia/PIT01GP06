import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projeto_final_flutter/features/transactions/metas/metas_repository.dart';

class FirebaseMock extends Mock implements FirebaseAuth {}

void main() async {
  // se primeiro acesso devolver lista vazia
  // se tiver algo, devolver uma lista de todomodel
  late FirebaseMetasRepository repository;
  late FakeFirebaseFirestore firestoreMock;
  late FirebaseMock firebaseAuth;

  setUp(() async {
    firebaseAuth = FirebaseMock();
    firestoreMock = FakeFirebaseFirestore();
    repository = FirebaseMetasRepository(firestoreMock, firebaseAuth);
  });

  test('deve retornar lista vazia se for primeiro acesso', (() async {
    final result = await repository.getMetas('');
    expect(result, isEmpty);
  }));

    test('O getTodo deve retornar algum valor', (() async {
    await firestoreMock.collection('IdUser').doc('userId').collection('contas').add({
      'goal' : 'meta',
      'objective' : 'Teste',
      'value' : 14.0,
      'date' : 1234,
      'idUser' : 'userId',
      'icon' : '',
      'perfomance' : 14.0,
    });
    final result = await repository.getMetas('userId');
    expect(result.length, 1);
    expect(result[0].date, DateTime.fromMillisecondsSinceEpoch(1234));
  }));
}
