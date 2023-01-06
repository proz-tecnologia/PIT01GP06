// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MetasModel {
  final String? id;
  final String objective;
  final double value;
  final DateTime date;
  final String idUser;
  final String icon;
  final double perfomance;
  MetasModel({
    this.id,
    required this.objective,
    required this.value,
    required this.date,
    required this.idUser,
    required this.icon,
    required this.perfomance,
  });

  MetasModel copyWith({
    String? id,
    String? objective,
    double? value,
    DateTime? date,
    String? idUser,
    String? icon,
    double? perfomance,
  }) {
    return MetasModel(
      id: id ?? this.id,
      objective: objective ?? this.objective,
      value: value ?? this.value,
      date: date ?? this.date,
      idUser: idUser ?? this.idUser,
      icon: icon ?? this.icon,
      perfomance: perfomance ?? this.perfomance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'objective': objective,
      'value': value,
      'date': date.millisecondsSinceEpoch,
      'idUser': idUser,
      'icon': icon,
      'perfomance': perfomance,
    };
  }

  factory MetasModel.fromMap(Map<String, dynamic> map) {
    return MetasModel(
      id: map['id'] != null ? map['id'] as String : null,
      objective: map['objective'] as String,
      value: map['value'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      idUser: map['idUser'] as String,
      icon: map['icon'] as String,
      perfomance: map['perfomance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetasModel.fromJson(String source) =>
      MetasModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MetasModel(id: $id, objective: $objective, value: $value, date: $date, idUser: $idUser, icon: $icon, perfomance: $perfomance)';
  }
}
