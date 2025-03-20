// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendPassword {
  final String password;
  SendPassword({
    required this.password,
  });

  SendPassword copyWith({
    String? password,
  }) {
    return SendPassword(
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
    };
  }

  factory SendPassword.fromMap(Map<String, dynamic> map) {
    return SendPassword(
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendPassword.fromJson(String source) => SendPassword.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SendPassword(password: $password)';

  @override
  bool operator ==(covariant SendPassword other) {
    if (identical(this, other)) return true;
  
    return 
      other.password == password;
  }

  @override
  int get hashCode => password.hashCode;
}
