// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddOrderModel {
  final String customer_phone;
  final List<HandCraft> handcraft;
  AddOrderModel({
    required this.customer_phone,
    required this.handcraft,
  });

  AddOrderModel copyWith({
    String? customer_phone,
    List<HandCraft>? handcraft,
  }) {
    return AddOrderModel(
      customer_phone: customer_phone ?? this.customer_phone,
      handcraft: handcraft ?? this.handcraft,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customer_phone': customer_phone,
      'handcraft': handcraft.map((x) => x.toMap()).toList(),
    };
  }

  factory AddOrderModel.fromMap(Map<String, dynamic> map) {
    return AddOrderModel(
      customer_phone: map['customer_phone'] as String,
      handcraft: List<HandCraft>.from(
        (map['handcraft'] as List<dynamic>).map<HandCraft>(
          (x) => HandCraft.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddOrderModel.fromJson(String source) =>
      AddOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AddOrderModel(customer_phone: $customer_phone, handcraft: $handcraft)';

  @override
  bool operator ==(covariant AddOrderModel other) {
    if (identical(this, other)) return true;

    return other.customer_phone == customer_phone &&
        listEquals(other.handcraft, handcraft);
  }

  @override
  int get hashCode => customer_phone.hashCode ^ handcraft.hashCode;
}

class HandCraft {
  final int handcraft_id;
  final int quantity;
  HandCraft({
    required this.handcraft_id,
    required this.quantity,
  });

  HandCraft copyWith({
    int? handcraft_id,
    int? quantity,
  }) {
    return HandCraft(
      handcraft_id: handcraft_id ?? this.handcraft_id,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'handcraft_id': handcraft_id,
      'quantity': quantity,
    };
  }

  factory HandCraft.fromMap(Map<String, dynamic> map) {
    return HandCraft(
      handcraft_id: map['handcraft_id'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HandCraft.fromJson(String source) =>
      HandCraft.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HandCraft(handcraft_id: $handcraft_id, quantity: $quantity)';

  @override
  bool operator ==(covariant HandCraft other) {
    if (identical(this, other)) return true;

    return other.handcraft_id == handcraft_id && other.quantity == quantity;
  }

  @override
  int get hashCode => handcraft_id.hashCode ^ quantity.hashCode;
}
