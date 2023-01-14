import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReceitasModel {
  String? descricao;
  String valor;
  String categoria;
  String data;
  String conta;
  
  ReceitasModel({
    this.descricao,
    required this.valor,
    required this.categoria,
    required this.data,
    required this.conta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'descricao': descricao,
      'valor': valor,
      'categoria': categoria,
      'data': data,
      'conta': conta,
    };
  }

  factory ReceitasModel.fromMap(Map<String, dynamic> map) {
    return ReceitasModel(
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      valor: map['valor'] as String,
      categoria: map['categoria'] as String,
      data: map['data'] as String,
      conta: map['conta'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceitasModel.fromJson(String source) => ReceitasModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReceitasModel(descricao: $descricao, valor: $valor, categoria: $categoria, data: $data, conta: $conta)';
  }
}
