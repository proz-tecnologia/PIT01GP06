// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardModel {
  String nomeCartao;
  String bandeiraCartao;
  String? contaDoCartao;
  String limiteCartao;

  CardModel({
    required this.nomeCartao,
    required this.bandeiraCartao,
    this.contaDoCartao,
    required this.limiteCartao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nomeCartao': nomeCartao,
      'bandeiraCartao': bandeiraCartao,
      'contaDoCartao': contaDoCartao,
      'limiteCartao': limiteCartao,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      nomeCartao: map['nomeCartao'] as String,
      bandeiraCartao: map['bandeiraCartao'] as String,
      contaDoCartao: map['contaDoCartao'] != null ? map['contaDoCartao'] as String : null,
      limiteCartao: map['limiteCartao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) => CardModel.fromMap(json.decode(source) as Map<String, dynamic>);


  @override
  String toString() {
    return 'CardModel(nomeCartao: $nomeCartao, bandeiraCartao: $bandeiraCartao, contaDoCartao: $contaDoCartao, limiteCartao: $limiteCartao)';
  }
}
