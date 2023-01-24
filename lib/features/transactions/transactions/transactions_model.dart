import 'dart:convert';

class TransactionModel {
  String? id;
  String type;
  String subtype;
  String descricao;
  double value;
  String nature;
  String idConta;
  DateTime dateTime;
  int day;
  int month;
  int year;
  String idUser;

  TransactionModel({
    this.id,
    required this.type,
    required this.subtype,
    required this.descricao,
    required this.value,
    required this.nature,
    required this.idConta,
    required this.dateTime,
    required this.day,
    required this.month,
    required this.year,
    required this.idUser,
  });

  TransactionModel copyWith({
    String? id,
    String? type,
    String? subtype,
    String? descricao,
    double? value,
    String? nature,
    String? idConta,
    DateTime? dateTime,
    int? day,
    int? month,
    int? year,
    String? idUser,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      descricao: descricao ?? this.descricao,
      value: value ?? this.value,
      nature: nature ?? this.nature,
      idConta: idConta ?? this.idConta,
      dateTime: dateTime ?? this.dateTime,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      idUser: idUser ?? this.idUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'subtype': subtype,
      'descricao': descricao,
      'value': value,
      'nature': nature,
      'idConta': idConta,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'day': day,
      'month': month,
      'year': year,
      'idUser': idUser,
    };
  }

  factory TransactionModel.fromMap(String id, Map<String, dynamic> map) {
    return TransactionModel(
      id: id,
      type: map['type'] as String,
      subtype: map['subtype'] as String,
      descricao: map['descricao'] as String,
      value: map['value'] as double,
      nature: map['nature'] as String,
      idConta: map['idConta'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      day: map['day'] as int,
      month: map['month'] as int,
      year: map['year'] as int,
      idUser: map['idUser'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TransactionModel(id: $id, type: $type, subtype: $subtype, descricao: $descricao, value: $value, nature: $nature, idConta: $idConta, dateTime: $dateTime, day: $day, month: $month, year: $year, idUser: $idUser)';
  }

  
}
