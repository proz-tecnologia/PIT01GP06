import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DespesasModel {
  String? descricao;
  String valor;
  String categoria;
  String subcategoria;
  String data;
  String conta;
  
  DespesasModel({
    this.descricao,
    required this.valor,
    required this.categoria,
    required this.subcategoria,
    required this.data,
    required this.conta,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'descricao': descricao,
      'valor': valor,
      'categoria': categoria,
      'subcategoria': subcategoria,
      'data': data,
      'conta': conta,
    };
  }

  factory DespesasModel.fromMap(Map<String, dynamic> map) {
    return DespesasModel(
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      valor: map['valor'] as String,
      categoria: map['categoria'] as String,
      subcategoria: map['subcategoria'] as String,
      data: map['data'] as String,
      conta: map['conta'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DespesasModel.fromJson(String source) => DespesasModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DespesasModel(descricao: $descricao, valor: $valor, categoria: $categoria, subcategoria: $subcategoria, data: $data, conta: $conta)';
  }
}
