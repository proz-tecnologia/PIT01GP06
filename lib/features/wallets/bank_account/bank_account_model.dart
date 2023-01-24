// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BankAccountModel {
  String? id;
  String type = 'receita';
  String subtype = 'corrente';
  String typeconta = 'Conta';
  String nomeConta;
  String nomeInstituicao;
  String tipoConta;  
  double balance;

  BankAccountModel({
    this.id,
    required this.type,
    required this.subtype,
    required this.typeconta,
    required this.nomeConta,
    required this.nomeInstituicao,
    required this.tipoConta,
    required this.balance,
  });

  BankAccountModel copyWith({
    String? id,
    String? type,    
    String? subtype,
    String? typeconta,
    String? nomeConta,
    String? nomeInstituicao,
    String? tipoConta,
    double? balance,
  }) {
    return BankAccountModel(
      id: id ?? this.id,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      typeconta: typeconta ?? this.typeconta,
      nomeConta: nomeConta ?? this.nomeConta,
      nomeInstituicao: nomeInstituicao ?? this.nomeInstituicao,
      tipoConta: tipoConta ?? this.tipoConta,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'subtype': subtype,
      'typeconta': typeconta,
      'nomeConta': nomeConta,
      'nomeInstituicao': nomeInstituicao,
      'tipoConta': tipoConta,
      'balance': balance,
    };
  }

  factory BankAccountModel.fromMap(String id, Map<String, dynamic> map) {
    return BankAccountModel(
      id: id,
      type: map['type'] as String,
      subtype: map['subtype'] as String,
      typeconta: map['typeconta'] as String,
      nomeConta: map['nomeConta'] as String,
      nomeInstituicao: map['nomeInstituicao'] as String,
      tipoConta: map['tipoConta'] as String,      
      balance: map['balance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  
}
