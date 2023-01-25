import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/constant.dart';
import '../wallets/bank_account/bank_account_model.dart';
import '../wallets/card/card_model.dart';

class TransactionsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot<Map<String, dynamic>>> getBankAccountsSnapshot() {
    return _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Conta')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCardsSnapshot() {
    return _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Cartão')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getDespesaSaldo(
      String categoria) {
    return _db
        .collection(db)
        .doc(_uid)
        .collection(transactions)
        .where("categoria", isEqualTo: categoria)
        .orderBy('data')
        .limit(1)
        .snapshots();
  }

  Future<List<CardModel>> getCard() async {
    final result = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Cartão')
        .orderBy('nomeCartao')
        .get();
    final todoCard = List<CardModel>.from(
        result.docs.map((doc) => CardModel.fromMap(doc.id, doc.data())));
    return todoCard;
  }

  Future<List<BankAccountModel>> getBalanceRevenues() async {
    final balanceRevenues = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("type", isEqualTo: 'receita')
        .where('typeconta', isEqualTo: 'Conta')
        .get();

    final todoBalance = List<BankAccountModel>.from(balanceRevenues.docs
        .map((doc) => BankAccountModel.fromMap(doc.id, doc.data())));
    print(todoBalance);
    return todoBalance;
  }
}
