import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  String type;
  String? descricao;
  double valor;
  String categoria;
  String? subcategoria;
  String idConta;
  DateTime dateTime;
  int day;
  int month;
  int year;
  String idUser;
  
  TransactionModel({
    required this.type,
    this.descricao,
    required this.valor,
    required this.categoria,
    this.subcategoria,
    required this.idConta,
    required this.dateTime,
    required this.day,
    required this.month,
    required this.year,
    required this.idUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'descricao': descricao,
      'valor': valor,
      'categoria': categoria,
      'subcategoria': subcategoria,
      'idConta': idConta,
      'dateTime': dateTime.microsecondsSinceEpoch,
      'day': day,
      'month': month,
      'year': year,
      'idUser': idUser,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      type: map['type'] as String,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      valor: map['valor'] as double,
      categoria: map['categoria'] as String,
      subcategoria: map['subcategoria'] != null ? map['subcategoria'] as String : null,
      idConta: map['idConta'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
      idUser: map['idUser'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(type: $type, descricao: $descricao, valor: $valor, categoria: $categoria, subcategoria: $subcategoria, idConta: $idConta, dateTime: $dateTime, day: $day, month: $month, year: $year, idUser: $idUser)';
  }
} 
