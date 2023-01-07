class MetasModel {
  final String? id;
  final String goal;
  final String objective;
  final double value;
  final DateTime date;
  final String idUser;
  final String icon;
  final double perfomance;

  MetasModel({
    this.id,
    required this.goal,
    required this.objective,
    required this.value,
    required this.date,
    required this.idUser,
    required this.icon,
    required this.perfomance,
  });

  MetasModel copyWith({
    String? id,
    String? goal,
    String? objective,
    double? value,
    DateTime? date,
    String? idUser,
    String? icon,
    double? perfomance,
  }) {
    return MetasModel(
      id: id ?? this.id,
      goal: goal ?? this.goal,
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
      'goal': goal,
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
      goal: map['goal'] as String,
      objective: map['objective'] as String,
      value: map['value'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      idUser: map['idUser'] as String,
      icon: map['icon'] as String,
      perfomance: map['perfomance'] as double,
    );
  }

  @override
  String toString() {
    return 'MetasModel(id: $id, goal: $goal, objective: $objective, value: $value, date: $date, idUser: $idUser, icon: $icon, perfomance: $perfomance)';
  }
}
