// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendCodeModel {
  final String code;
  SendCodeModel({
    required this.code,
  });

  SendCodeModel copyWith({
    String? code,
  }) {
    return SendCodeModel(
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
    };
  }

  factory SendCodeModel.fromMap(Map<String, dynamic> map) {
    return SendCodeModel(
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendCodeModel.fromJson(String source) => SendCodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SendCodeModel(code: $code)';

  @override
  bool operator ==(covariant SendCodeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}
