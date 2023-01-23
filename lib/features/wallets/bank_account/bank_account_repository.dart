import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/constant.dart';
import 'bank_account_model.dart';

abstract class IBankAccountRepository {
  Future<void> addBankAccount(BankAccountModel bankAccount);
}

class BankAccountRepository implements IBankAccountRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> addBankAccount(BankAccountModel bankAccount) {
    return _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .add(bankAccount.toMap());
  }
}
