// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  String? id;
  String type = 'despesa';
  String typeconta = 'Cartão';
  String nomeCartao;
  String bandeiraCartao;
  String? contaDoCartao;
  double limiteCartao;
  num balance;
  Timestamp dateReg;

  CardModel({
    this.id,
    required this.type,
    required this.typeconta,
    required this.nomeCartao,
    required this.bandeiraCartao,
    this.contaDoCartao,
    required this.limiteCartao,
    required this.balance,
    required this.dateReg,
  });

  CardModel copyWith({
    String? id,
    String? type,
    String? typeconta,
    String? nomeCartao,
    String? bandeiraCartao,
    String? contaDoCartao,
    double? limiteCartao,
    double? balance,
    Timestamp? dateReg,
  }) {
    return CardModel(
      id: id ?? this.id,
      type: type ?? this.type,
      typeconta: typeconta ?? this.typeconta,
      nomeCartao: nomeCartao ?? this.nomeCartao,
      bandeiraCartao: bandeiraCartao ?? this.bandeiraCartao,
      contaDoCartao: contaDoCartao ?? this.contaDoCartao,
      limiteCartao: limiteCartao ?? this.limiteCartao,
      balance: balance ?? this.balance,
      dateReg: dateReg ?? this.dateReg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'typeconta': typeconta,
      'nomeCartao': nomeCartao,
      'bandeiraCartao': bandeiraCartao,
      'contaDoCartao': contaDoCartao,
      'limiteCartao': limiteCartao,
      'balance': balance,
      'dateReg': dateReg
    };
  }

  factory CardModel.fromMap(String id, Map<String, dynamic> map) {
    return CardModel(
      id: id,
      type: map['type'] as String,
      typeconta: map['typeconta'] as String,
      nomeCartao: map['nomeCartao'] as String,
      bandeiraCartao: map['bandeiraCartao'] as String,
      contaDoCartao:
          map['contaDoCartao'] != null ? map['contaDoCartao'] as String : null,
      limiteCartao: map['limiteCartao'] as double,
      balance: map['balance'] as num,
      dateReg: map['dateReg'] as Timestamp,

    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CardModel(id: $id, nomeCartao: $nomeCartao, bandeiraCartao: $bandeiraCartao, contaDoCartao: $contaDoCartao, limiteCartao: $limiteCartao, balance: $balance, dateReg: $dateReg)';
  }
}
