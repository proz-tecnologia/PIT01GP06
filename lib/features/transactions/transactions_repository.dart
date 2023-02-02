import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/classes.dart';
import '../../shared/constant.dart';
import '../grafics/grafic_expenses.dart';
import '../wallets/bank_account/bank_account_model.dart';
import '../wallets/card/card_model.dart';

class TransactionsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  Future<List<String>> getListBankAccountsSnapshot() async {
    List<String> bankAccounts = [];

    final querySnapshot = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Conta')
        .get();

    querySnapshot.docs.forEach((doc) {
      bankAccounts.add(doc['nomeConta']);
    });

    return bankAccounts;
  }

  Future<List<String>> getListCardsSnapshot() async {
    List<String> cardsAccounts = [];

    final querySnapshot = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("typeconta", isEqualTo: 'Cartão')
        .get();

   querySnapshot.docs.forEach((doc) {
        cardsAccounts.add(doc['nomeCartao']);
      });

      return cardsAccounts;
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
    return todoBalance;
  }

  Future<List<BankAccountModel>> getBalanceSavings() async {
    final balanceSavings = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where("type", isEqualTo: 'receita')
        .where('typeconta', isEqualTo: 'Conta')
        .where('tipoConta', isEqualTo: 'Poupança')
        .get();

    final todoBalance = List<BankAccountModel>.from(balanceSavings.docs
        .map((doc) => BankAccountModel.fromMap(doc.id, doc.data())));

    return todoBalance;
  }

  Future<List<ChartSampleData>?> getExpensesSnapshot(
      int month, int year) async {
    List<ChartSampleData> listExpenses = [];

    final querySnapshot = await _db
        .collection(db)
        .doc(_uid)
        .collection(transactions)
        .where("type", isEqualTo: 'despesa')
        .where('month', isEqualTo: month)
        .where('year', isEqualTo: year)
        .orderBy('day')
        .get();

    int day = 1;
    double soma = 0.0;

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        if (day == doc['day']) {
          soma = soma + doc['balance'];
        } else {
          listExpenses.add(ChartSampleData(doc['day'], soma));
          // print(MyData(doc['day'], soma));
          day = doc['day'];
          soma = 0.0;
        }
      }
      return listExpenses;
    } else {
      return null;
    }
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

    BalanceUser resultado =
        BalanceUser(mes, ano, monthname!, receitas, despesas, saldo);
    return resultado;
  }

  Future<List<Map<String, dynamic>>?> getListWallet() async {
    List<Map<String, dynamic>> listWallet = [];

    final querySnapshot = await _db
        .collection(db)
        .doc(_uid)
        .collection(accounts)
        .where('typeconta', whereIn: ["Cartão", "Conta"]).get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map idWallet = {'id': doc.id};
        Map<String, dynamic> combinado = Map.from(idWallet)..addAll(doc.data());
        listWallet.add(combinado);
      }
    }
    return listWallet;
  }
}

class SampleData {
  final int x;
  final double y;
  SampleData(this.x, this.y);
}
