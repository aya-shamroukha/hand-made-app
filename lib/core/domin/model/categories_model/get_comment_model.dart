// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetCommentModel {
  final int id;
  final int customer;
  final String customer_name;
  final int handcraft;
  final String date;
  final String description;
  GetCommentModel({
    required this.id,
    required this.customer,
    required this.customer_name,
    required this.handcraft,
    required this.date,
    required this.description,
  });

  GetCommentModel copyWith({
    int? id,
    int? customer,
    String? customer_name,
    int? handcraft,
    String? date,
    String? description,
  }) {
    return GetCommentModel(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      customer_name: customer_name ?? this.customer_name,
      handcraft: handcraft ?? this.handcraft,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customer': customer,
      'customer_name': customer_name,
      'handcraft': handcraft,
      'date': date,
      'description': description,
    };
  }

  factory GetCommentModel.fromMap(Map<String, dynamic> map) {
    return GetCommentModel(
      id: map['id'] as int,
      customer: map['customer'] as int,
      customer_name: map['customer_name'] as String,
      handcraft: map['handcraft'] as int,
      date: map['date'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetCommentModel.fromJson(String source) => GetCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetCommentModel(id: $id, customer: $customer, customer_name: $customer_name, handcraft: $handcraft, date: $date, description: $description)';
  }

  @override
  bool operator ==(covariant GetCommentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.customer == customer &&
      other.customer_name == customer_name &&
      other.handcraft == handcraft &&
      other.date == date &&
      other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      customer.hashCode ^
      customer_name.hashCode ^
      handcraft.hashCode ^
      date.hashCode ^
      description.hashCode;
  }
}
