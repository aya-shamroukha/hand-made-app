// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendCodeModel {
  final String code;
  final String email;
  SendCodeModel({
    required this.code,
    required this.email,
  });

  SendCodeModel copyWith({
    String? code,
    String? email,
  }) {
    return SendCodeModel(
      code: code ?? this.code,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'email': email,
    };
  }

  factory SendCodeModel.fromMap(Map<String, dynamic> map) {
    return SendCodeModel(
      code: map['code'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendCodeModel.fromJson(String source) =>
      SendCodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SendCodeModel(code: $code, email: $email)';

  @override
  bool operator ==(covariant SendCodeModel other) {
    if (identical(this, other)) return true;

    return other.code == code && other.email == email;
  }

  @override
  int get hashCode => code.hashCode ^ email.hashCode;
}

class SendEmailModel {
  final String email;
  SendEmailModel({
    required this.email,
  });

  SendEmailModel copyWith({
    String? email,
  }) {
    return SendEmailModel(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory SendEmailModel.fromMap(Map<String, dynamic> map) {
    return SendEmailModel(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendEmailModel.fromJson(String source) =>
      SendEmailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SendEmailModel(email: $email)';

  @override
  bool operator ==(covariant SendEmailModel other) {
    if (identical(this, other)) return true;

    return other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

class SendPasswordModel {
  final String new_password;
  final String email;
  SendPasswordModel({
    required this.new_password,
    required this.email,
  });

  SendPasswordModel copyWith({
    String? new_password,
    String? email,
  }) {
    return SendPasswordModel(
      new_password: new_password ?? this.new_password,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new_password': new_password,
      'email': email,
    };
  }

  factory SendPasswordModel.fromMap(Map<String, dynamic> map) {
    return SendPasswordModel(
      new_password: map['new_password'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendPasswordModel.fromJson(String source) => SendPasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SendPasswordModel(new_password: $new_password, email: $email)';

  @override
  bool operator ==(covariant SendPasswordModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.new_password == new_password &&
      other.email == email;
  }

  @override
  int get hashCode => new_password.hashCode ^ email.hashCode;
}
