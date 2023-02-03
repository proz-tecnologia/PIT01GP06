class MetasModel {
  final String? id;
  final String goal;
  final String objective;
  final double value;
  final DateTime date;
  final String idUser;
  
  MetasModel({
    this.id,
    required this.goal,
    required this.objective,
    required this.value,
    required this.date,
    required this.idUser,  
  });

  MetasModel copyWith({
    String? id,
    String? goal,
    String? objective,
    double? value,
    DateTime? date,
    String? idUser,
    String? icon,    
  }) {
    return MetasModel(
      id: id ?? this.id,
      goal: goal ?? this.goal,
      objective: objective ?? this.objective,
      value: value ?? this.value,
      date: date ?? this.date,
      idUser: idUser ?? this.idUser,     
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'goal': goal,
      'objective': objective,
      'value': value,
      'date': date.millisecondsSinceEpoch,
      'idUser': idUser,   
    };
  }

  factory MetasModel.fromMap(String id, Map<String, dynamic> map) {
    return MetasModel(
      id: id,
      goal: map['goal'] as String,
      objective: map['objective'] as String,
      value: map['value'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      idUser: map['idUser'] as String,  
    );
  }

  @override
  String toString() {
    return 'MetasModel(id: $id, goal: $goal, objective: $objective, value: $value, date: $date, idUser: $idUser)';
  }
}
