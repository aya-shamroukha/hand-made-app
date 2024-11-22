// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class SignUpModel {
  String username;
  String phone_number;
  String email;
  String password;
  String name;
  SignUpModel({
    required this.username,
    required this.phone_number,
    required this.email,
    required this.password,
    required this.name,
  });

  SignUpModel copyWith({
    String? username,
    String? phone_number,
    String? email,
    String? password,
    String? name,
  }) {
    return SignUpModel(
      username: username ?? this.username,
      phone_number: phone_number ?? this.phone_number,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'phone_number': phone_number,
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      username: map['username'] as String,
      phone_number: map['phone_number'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) =>
      SignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpModel(username: $username, phone_number: $phone_number, email: $email, password: $password, name: $name)';
  }

  @override
  bool operator ==(covariant SignUpModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.phone_number == phone_number &&
        other.email == email &&
        other.password == password &&
        other.name == name;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        phone_number.hashCode ^
        email.hashCode ^
        password.hashCode ^
        name.hashCode;
  }
}
