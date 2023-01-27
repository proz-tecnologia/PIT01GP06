// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReceitasModel {
  String? id;
  String type = 'receita';
  String typeconta = 'avulsa';
  String? descricao;
  double valor;
  double balance;
  String categoria;
  String data;
  String conta;

  ReceitasModel({
    this.id,
    required this.type,
    required this.typeconta,
    required descricao,
    required this.valor,
    required this.balance,
    required this.categoria,
    required this.data,
    required this.conta,
  });

  ReceitasModel copyWith({
    String? id,
    String? type,
    String? typeconta,
    String? descricao,
    double? valor,
    double? balance,
    String? categoria,
    String? data,
    String? conta,
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
      conta: conta ?? this.conta,
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
      'data': data,
      'conta': conta,
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
      data: map['data'] as String,
      conta: map['conta'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ReceitasModel(id: $id, type: $type, typeconta: $typeconta, descricao: $descricao, valor: $valor, balance: $balance, categoria: $categoria, data: $data, conta: $conta)';
  }
}
