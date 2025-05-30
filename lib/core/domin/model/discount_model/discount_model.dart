// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DiscountModel {
  final String name;
  final dynamic precentage;
  final String from_date;
  final String to_date;
  final int count;
  final List<dynamic> handcrafts;
  DiscountModel({
    required this.name,
    required this.precentage,
    required this.from_date,
    required this.to_date,
    required this.count,
    required this.handcrafts,
  });

  DiscountModel copyWith({
    String? name,
    dynamic precentage,
    String? from_date,
    String? to_date,
    int? count,
    List<dynamic>? handcrafts,
  }) {
    return DiscountModel(
      name: name ?? this.name,
      precentage: precentage ?? this.precentage,
      from_date: from_date ?? this.from_date,
      to_date: to_date ?? this.to_date,
      count: count ?? this.count,
      handcrafts: handcrafts ?? this.handcrafts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'precentage': precentage,
      'from_date': from_date,
      'to_date': to_date,
      'count': count,
      'handcrafts': handcrafts,
    };
  }

  factory DiscountModel.fromMap(Map<String, dynamic> map) {
    return DiscountModel(
      name: map['name'] as String,
      precentage: map['precentage'] as dynamic,
      from_date: map['from_date'] as String,
      to_date: map['to_date'] as String,
      count: map['count'] as int,
      handcrafts: List<dynamic>.from((map['handcrafts'] as List<dynamic>),
     ) );
  }

  String toJson() => json.encode(toMap());

  factory DiscountModel.fromJson(String source) => DiscountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DiscountModel(name: $name, precentage: $precentage, from_date: $from_date, to_date: $to_date, count: $count, handcrafts: $handcrafts)';
  }

  @override
  bool operator ==(covariant DiscountModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.precentage == precentage &&
      other.from_date == from_date &&
      other.to_date == to_date &&
      other.count == count &&
      listEquals(other.handcrafts, handcrafts);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      precentage.hashCode ^
      from_date.hashCode ^
      to_date.hashCode ^
      count.hashCode ^
      handcrafts.hashCode;
  }
}

class HandCrafts {
  final int id;
  final HandCraft handCraft;
  final int discount;
  HandCrafts({
    required this.id,
    required this.handCraft,
    required this.discount,
  });

  HandCrafts copyWith({
    int? id,
    HandCraft? handCraft,
    int? discount,
  }) {
    return HandCrafts(
      id: id ?? this.id,
      handCraft: handCraft ?? this.handCraft,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'handCraft': handCraft.toMap(),
      'discount': discount,
    };
  }

  factory HandCrafts.fromMap(Map<String, dynamic> map) {
    return HandCrafts(
      id: map['id'] as int,
      handCraft: HandCraft.fromMap(map['handCraft'] as Map<String,dynamic>),
      discount: map['discount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HandCrafts.fromJson(String source) => HandCrafts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HandCrafts(id: $id, handCraft: $handCraft, discount: $discount)';

  @override
  bool operator ==(covariant HandCrafts other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.handCraft == handCraft &&
      other.discount == discount;
  }

  @override
  int get hashCode => id.hashCode ^ handCraft.hashCode ^ discount.hashCode;
}

class HandCraft {
  final int id;
  final String handcraft_name;
  final String handcraft_price;
  final int handcraft_count;
  final String handcraft_image;
  final int category;
  final int maker;
  HandCraft({
    required this.id,
    required this.handcraft_name,
    required this.handcraft_price,
    required this.handcraft_count,
    required this.handcraft_image,
    required this.category,
    required this.maker,
  });

  HandCraft copyWith({
    int? id,
    String? handcraft_name,
    String? handcraft_price,
    int? handcraft_count,
    String? handcraft_image,
    int? category,
    int? maker,
  }) {
    return HandCraft(
      id: id ?? this.id,
      handcraft_name: handcraft_name ?? this.handcraft_name,
      handcraft_price: handcraft_price ?? this.handcraft_price,
      handcraft_count: handcraft_count ?? this.handcraft_count,
      handcraft_image: handcraft_image ?? this.handcraft_image,
      category: category ?? this.category,
      maker: maker ?? this.maker,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'handcraft_name': handcraft_name,
      'handcraft_price': handcraft_price,
      'handcraft_count': handcraft_count,
      'handcraft_image': handcraft_image,
      'category': category,
      'maker': maker,
    };
  }

  factory HandCraft.fromMap(Map<String, dynamic> map) {
    return HandCraft(
      id: map['id'] as int,
      handcraft_name: map['handcraft_name'] as String,
      handcraft_price: map['handcraft_price'] as String,
      handcraft_count: map['handcraft_count'] as int,
      handcraft_image: map['handcraft_image'] as String,
      category: map['category'] as int,
      maker: map['maker'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HandCraft.fromJson(String source) =>
      HandCraft.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HandCraft(id: $id, handcraft_name: $handcraft_name, handcraft_price: $handcraft_price, handcraft_count: $handcraft_count, handcraft_image: $handcraft_image, category: $category, maker: $maker)';
  }

  @override
  bool operator ==(covariant HandCraft other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.handcraft_name == handcraft_name &&
        other.handcraft_price == handcraft_price &&
        other.handcraft_count == handcraft_count &&
        other.handcraft_image == handcraft_image &&
        other.category == category &&
        other.maker == maker;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        handcraft_name.hashCode ^
        handcraft_price.hashCode ^
        handcraft_count.hashCode ^
        handcraft_image.hashCode ^
        category.hashCode ^
        maker.hashCode;
  }
}
