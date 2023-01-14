import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BankAccountModel {
  String nomeConta;
  String nomeInstituicao;
  String tipoConta;
  String saldoConta;
  
  BankAccountModel({
    required this.nomeConta,
    required this.nomeInstituicao,
    required this.tipoConta,
    required this.saldoConta,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nomeConta': nomeConta,
      'nomeInstituicao': nomeInstituicao,
      'tipoConta': tipoConta,
      'saldoConta': saldoConta,
    };
  }

  factory BankAccountModel.fromMap(Map<String, dynamic> map) {
    return BankAccountModel(
      nomeConta: map['nomeConta'] as String,
      nomeInstituicao: map['nomeInstituicao'] as String,
      tipoConta: map['tipoConta'] as String,
      saldoConta: map['saldoConta'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankAccountModel.fromJson(String source) => BankAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BankAccountModel(nomeConta: $nomeConta, nomeInstituicao: $nomeInstituicao, tipoConta: $tipoConta, saldoConta: $saldoConta)';
  }
}
