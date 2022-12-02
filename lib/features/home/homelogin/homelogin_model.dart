// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String? loginId;
  final String email;
  final String pwd;

  User({
    this.loginId,
    required this.email,
    required this.pwd,
  });

  User copyWith({
    String? loginId,
    String? email,
    String? pwd,
  }) {
    return User(
      loginId: loginId ?? this.loginId,
      email: email ?? this.email,
      pwd: pwd ?? this.pwd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loginId': loginId,
      'email': email,
      'pwd': pwd,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      loginId: map['loginId'] != null ? map['loginId'] as String : null,
      email: map['email'] as String,
      pwd: map['pwd'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(loginId: $loginId, email: $email, pwd: $pwd)';
}
