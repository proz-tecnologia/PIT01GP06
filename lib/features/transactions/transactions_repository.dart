import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/classes.dart';
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

  Future<BalanceUser> getBalanceUser(int mes, int ano) async {
    final balanceUser = await _db
        .collection(db)
        .doc(_uid)
        .collection(transactions)
        .where('month', isEqualTo: mes)
        .where('year', isEqualTo: ano)
        .get();

    final todoBalanceUsers = List<ListAccounts>.from(balanceUser.docs
        .map((doc) => ListAccounts.fromMap(doc.id, doc.data())));

    double receitas = 0.0;
    double despesas = 0.0;
    double saldo = 0.0;
    String? monthname;
    // String monthname = '';
    Map<int, String> meses = {
      1: "janeiro",
      2: "fevereiro",
      3: "março",
      4: "abril",
      5: "maio",
      6: "junho",
      7: "julho",
      8: "agosto",
      9: "setembro",
      10: "outubro",
      11: "novembro",
      12: "dezembro"
    };

    monthname = meses[mes];

    for (var todoBalanceUser in todoBalanceUsers) {
      if (todoBalanceUser.type == 'receita') {
        receitas = receitas + todoBalanceUser.valor;
      } else {
        despesas = despesas + todoBalanceUser.valor;
      }     
    }
    saldo = receitas - despesas;
    print("o valor apurado foi: receitas = $receitas, despesas = $despesas");
    
    BalanceUser resultado =
        BalanceUser(mes, ano, monthname!, receitas, despesas, saldo);
    print(resultado);
    return resultado;
  }
}
