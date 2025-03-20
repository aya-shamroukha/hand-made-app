// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  factory SendEmailModel.fromJson(String source) => SendEmailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SendEmailModel(email: $email)';

  @override
  bool operator ==(covariant SendEmailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
