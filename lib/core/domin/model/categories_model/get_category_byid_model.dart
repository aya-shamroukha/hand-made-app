// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetCategoryByIdModel {
  final int id;

  final int handcraft_count;
  final String handcraft_name;
  final String handcraft_price;
  final String handcraft_image;
  final List discounts;
  final double discounted_price;
  GetCategoryByIdModel({
    required this.id,
    required this.handcraft_count,
    required this.handcraft_name,
    required this.handcraft_price,
    required this.handcraft_image,
    required this.discounts,
    required this.discounted_price,
  });

  GetCategoryByIdModel copyWith({
    int? id,
    int? category,
    int? maker,
    int? handcraft_count,
    String? handcraft_name,
    String? handcraft_price,
    String? handcraft_image,
    List? discounts,
    double? discounted_price,
  }) {
    return GetCategoryByIdModel(
      id: id ?? this.id,
      handcraft_count: handcraft_count ?? this.handcraft_count,
      handcraft_name: handcraft_name ?? this.handcraft_name,
      handcraft_price: handcraft_price ?? this.handcraft_price,
      handcraft_image: handcraft_image ?? this.handcraft_image,
      discounts: discounts ?? this.discounts,
      discounted_price: discounted_price ?? this.discounted_price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'handcraft_count': handcraft_count,
      'handcraft_name': handcraft_name,
      'handcraft_price': handcraft_price,
      'handcraft_image': handcraft_image,
      'discounts': discounts,
      'discounted_price': discounted_price,
    };
  }

  factory GetCategoryByIdModel.fromMap(Map<String, dynamic> map) {
    return GetCategoryByIdModel(
      id: map['id'] as int,
      handcraft_count: map['handcraft_count'] as int,
      handcraft_name: map['handcraft_name'] as String,
      handcraft_price: map['handcraft_price'] as String,
      handcraft_image: map['handcraft_image'] as String,
      discounts:
          map['discounts'] != null ? List.from(map['discounts'] as List) : [],
      discounted_price: map['discounted_price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetCategoryByIdModel.fromJson(String source) =>
      GetCategoryByIdModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetCategoryByIdModel(id: $id, handcraft_count: $handcraft_count, handcraft_name: $handcraft_name, handcraft_price: $handcraft_price, handcraft_image: $handcraft_image, discounts: $discounts, discounted_price: $discounted_price)';
  }

  @override
  bool operator ==(covariant GetCategoryByIdModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.handcraft_count == handcraft_count &&
        other.handcraft_name == handcraft_name &&
        other.handcraft_price == handcraft_price &&
        other.handcraft_image == handcraft_image &&
        listEquals(other.discounts, discounts) &&
        other.discounted_price == discounted_price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        handcraft_count.hashCode ^
        handcraft_name.hashCode ^
        handcraft_price.hashCode ^
        handcraft_image.hashCode ^
        discounts.hashCode ^
        discounted_price.hashCode;
  }
}
