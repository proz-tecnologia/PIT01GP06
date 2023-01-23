//sucesso: se logou e devolveu um userModel
//erro não existe o usuario
//erro conexão com firebase

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final_flutter/features/home/homelogin/homelogin_model.dart';
import 'package:projeto_final_flutter/features/home/homelogin/homelogin_repository.dart';
import 'package:projeto_final_flutter/firebase_options.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

class UserMock extends Mock implements User {}

void main() async {
  late FirebaseRepository repository;
  late FirebaseMock firebaseAuth;
  late UserCredentialMock userCredential;
  late UserMock user;

  setUp(() async {
    firebaseAuth = FirebaseMock();
    repository = FirebaseRepository(firebaseAuth);
    userCredential = UserCredentialMock();
    user = UserMock();
  });

  group('method login', () {
    test(
      "success case: the HomeLoginState should return an User",
      () async {
        when(() => firebaseAuth.signInWithEmailAndPassword(
                email: any(named: 'email'), password: any(named: 'password')))
            .thenAnswer((invocation) async => userCredential);
        when(() => userCredential.user,
        ).thenReturn(user);
        final result = await repository.login('marcus@gmail.com', '123456');
        expect(result, isA<UserModel>());
        expect(result.email, 'marcus@gmail.com');
      },
    );
    test(
      "error case: check if user is null and if so, throws an Exception",
      () async {
         when(() => firebaseAuth.signInWithEmailAndPassword(
                email: any(named: 'email'), password: any(named: 'password')))
            .thenAnswer((invocation) async => userCredential);
      
        expect(userCredential.user, null);
        expect(() async => repository.login('marcus@gmail.com', '123456'), throwsException);
      },
    );
    test(
      "firebase connection error",
      () async {
         when(() => firebaseAuth.signInWithEmailAndPassword(
                email: any(named: 'email'), password: any(named: 'password')))
            .thenThrow(Exception());
      
        expect(() async => repository.login('marcus@gmail.com', '123456'), throwsException);
      },
    );
  });
}
