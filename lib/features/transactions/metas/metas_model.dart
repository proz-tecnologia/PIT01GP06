import 'dart:convert';

class MetasModel {
  final String? id;
  final String objective;
  final int value;
  final DateTime date;
  final String idUser;
  final String icon;
  final int perfomance;

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
    int? value,
    DateTime? date,
    String? idUser,
    String? icon,
    int? perfomance,
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
      'objective': objective,
      'value': value,
      'date': date.millisecondsSinceEpoch,
      'idUser': idUser,
      'icon': icon,
      'perfomance': perfomance,
    };
  }

  factory MetasModel.fromMap(String id, Map<String, dynamic> map) {
    return MetasModel(
      id: id, //map['id'] != null ? map['id'] as String : null,
      objective: map['objective'] as String,
      value: map['value'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      idUser: map['idUser'] as String,
      icon: map['icon'] as String,
      perfomance: map['perfomance'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'MetasModel(id: $id, objective: $objective, value: $value, date: $date, idUser: $idUser, icon: $icon, perfomance: $perfomance)';
  }
}
