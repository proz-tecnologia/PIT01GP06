// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../features/transactions/despesas/despesas_model.dart';
import '../features/wallets/bank_account/bank_account_model.dart';

class ListaBank {
  final List<BankAccountModel> listBank;
  ListaBank(this.listBank);
}

class ListaDespesa {
  final List<DespesasModel> listDespesa;
  ListaDespesa(this.listDespesa);
}

class BalanceUser {
  int mes;
  int ano;
  String monthname;
  double receitas;
  double despesas;
  double saldo;

  BalanceUser(this.mes, this.ano, this.monthname, this.receitas, this.despesas,
      this.saldo);

  void resultado() {
    saldo = receitas - despesas;
  }
}

class ListAccounts {
  String id;
  String type;
  double valor;
  DateTime data;
  int day;
  int month;
  int year;

  ListAccounts({
    required this.id,
    required this.type,
    required this.valor,
    required this.data,
    required this.day,
    required this.month,
    required this.year,
  });

  ListAccounts copyWith({
    String? id,
    String? type,
    double? valor,
    DateTime? data,
    int? day,
    int? month,
    int? year,
  }) {
    return ListAccounts(
      id: id ?? this.id,
      type: type ?? this.type,
      valor: valor ?? this.valor,
      data: data ?? this.data,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'valor': valor,
      'data': data.millisecondsSinceEpoch,
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory ListAccounts.fromMap(String id, Map<String, dynamic> map) {
    return ListAccounts(
      id: id,
      type: map['type'] as String,
      valor: map['valor'] as double,
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
    );
  }

  String toJson() => json.encode(toMap());
}
