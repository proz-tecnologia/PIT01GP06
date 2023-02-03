// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReceitasModel {
  String? id;
  String type = 'receita';
  String typeconta = 'avulsa';
  String? descricao;
  double valor;
  double balance;
  String categoria;
  DateTime data;
  int day;
  int month;
  int year;
  String conta;
  Timestamp dateReg;

  ReceitasModel({
    this.id,
    required this.type,
    required this.typeconta,
    required descricao,
    required this.valor,
    required this.balance,
    required this.categoria,
    required this.data,
    required this.day,
    required this.month,
    required this.year,
    required this.conta,
    required this.dateReg,
  });

  ReceitasModel copyWith({
    String? id,
    String? type,
    String? typeconta,
    String? descricao,
    double? valor,
    double? balance,
    String? categoria,
    DateTime? data,
    int? day,
    int? month,
    int? year,
    String? conta,
    Timestamp? dateReg,
  }) {
    return ReceitasModel(
      id: id ?? this.id,
      type: type ?? this.type,
      typeconta: typeconta ?? this.typeconta,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      balance: balance ?? this.balance,
      categoria: categoria ?? this.categoria,
      data: data ?? this.data,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      conta: conta ?? this.conta,
      dateReg: dateReg ?? this.dateReg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'typeconta': typeconta,
      'descricao': descricao,
      'valor': valor,
      'balance': balance,
      'categoria': categoria,
      'data':data.millisecondsSinceEpoch,
      'day': day,
      'month': month,
      'year': year,
      'conta': conta,
      'dateReg': dateReg
    };
  }

  factory ReceitasModel.fromMap(String id, Map<String, dynamic> map) {
    return ReceitasModel(
      id: id,
      type: map['type'] as String,
      typeconta: map['typeconta'] as String,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      valor: map['valor'] as double,
      balance: map['balance'] as double,
      categoria: map['categoria'] as String,
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
      conta: map['conta'] as String,
      dateReg: map['dateReg'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  

  @override
  String toString() {
    return 'ReceitasModel(id: $id, type: $type, typeconta: $typeconta, descricao: $descricao, valor: $valor, balance: $balance, categoria: $categoria, data: $data, day: $day, month: $month, year: $year, conta: $conta, dateReg: $dateReg)';
  }
}
