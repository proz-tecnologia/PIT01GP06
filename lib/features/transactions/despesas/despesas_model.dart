// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DespesasModel {
  String? id;
  String type = 'despesa';
  String? descricao;
  double valor;
  double balance;
  String categoria;
  String subcategoria;
  int timeReg;
  DateTime data;
  int day;
  int month;
  int year;
  String typeconta;
  String conta;

  DespesasModel({
    this.id,
    required this.type,
    this.descricao,
    required this.valor,
    required this.balance,
    required this.categoria,
    required this.subcategoria,
    required this.timeReg,
    required this.data,
    required this.day,
    required this.month,
    required this.year,
    required this.typeconta,
    required this.conta,
  });

  DespesasModel copyWith({
    String? id,
    String? type,
    String? descricao,
    double? valor,
    double? balance,
    String? categoria,
    String? subcategoria,
    int? timeReg,
    DateTime? data,
    int? day,
    int? month,
    int? year,
    String? typeconta,
    String? conta,
  }) {
    return DespesasModel(
      id: id ?? this.id,
      type: type ?? this.type,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      balance: balance ?? this.balance,
      categoria: categoria ?? this.categoria,
      subcategoria: subcategoria ?? this.subcategoria,
      timeReg: timeReg ?? this.timeReg,
      data: data ?? this.data,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      typeconta: typeconta ?? this.typeconta,
      conta: conta ?? this.conta,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'descricao': descricao,
      'valor': valor,
      'balance': balance,
      'categoria': categoria,
      'subcategoria': subcategoria,
      'timeReg': timeReg,
      'data': data.millisecondsSinceEpoch,
      'day': day,
      'month': month,
      'year': year,
      'typeconta': typeconta,
      'conta': conta,
    };
  }

  factory DespesasModel.fromMap(String id, Map<String, dynamic> map) {
    return DespesasModel(
      id: id,
      type: map['type'] as String,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      valor: map['valor'] as double,
      balance: map['balance'] as double,
      categoria: map['categoria'] as String,
      subcategoria: map['subcategoria'] as String,
      timeReg: map['timeReg'] as int,
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
      typeconta: map['typeconta'] as String,
      conta: map['conta'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  
}
