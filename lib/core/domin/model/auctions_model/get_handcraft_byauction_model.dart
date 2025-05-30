// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hand_made_app/core/domin/model/auctions_model/get_maker_byauction_model.dart';

class GetHandcraftByAuctionModel {
  final int id;
  final int handcraft_count;
  final String handcraft_name;
  final String handcraft_price;
  final String handcraft_image;
  final GetMakerByAuctionModel maker;
  final int category;
  GetHandcraftByAuctionModel({
    required this.id,
    required this.handcraft_count,
    required this.handcraft_name,
    required this.handcraft_price,
    required this.handcraft_image,
    required this.maker,
    required this.category,
  });

  GetHandcraftByAuctionModel copyWith({
    int? id,
    int? handcraft_count,
    String? handcraft_name,
    String? handcraft_price,
    String? handcraft_image,
    GetMakerByAuctionModel? maker,
    int? category,
  }) {
    return GetHandcraftByAuctionModel(
      id: id ?? this.id,
      handcraft_count: handcraft_count ?? this.handcraft_count,
      handcraft_name: handcraft_name ?? this.handcraft_name,
      handcraft_price: handcraft_price ?? this.handcraft_price,
      handcraft_image: handcraft_image ?? this.handcraft_image,
      maker: maker ?? this.maker,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'handcraft_count': handcraft_count,
      'handcraft_name': handcraft_name,
      'handcraft_price': handcraft_price,
      'handcraft_image': handcraft_image,
      'maker': maker.toMap(),
      'category': category,
    };
  }

  factory GetHandcraftByAuctionModel.fromMap(Map<String, dynamic> map) {
    return GetHandcraftByAuctionModel(
      id: map['id'] as int,
      handcraft_count: map['handcraft_count'] as int,
      handcraft_name: map['handcraft_name'] as String,
      handcraft_price: map['handcraft_price'] as String,
      handcraft_image: map['handcraft_image'] as String,
      maker:
          GetMakerByAuctionModel.fromMap(map['maker'] as Map<String, dynamic>),
      category: map['category'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetHandcraftByAuctionModel.fromJson(String source) =>
      GetHandcraftByAuctionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetHandcraftByAuctionModel(id: $id, handcraft_count: $handcraft_count, handcraft_name: $handcraft_name, handcraft_price: $handcraft_price, handcraft_image: $handcraft_image, maker: $maker, category: $category)';
  }

  @override
  bool operator ==(covariant GetHandcraftByAuctionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.handcraft_count == handcraft_count &&
        other.handcraft_name == handcraft_name &&
        other.handcraft_price == handcraft_price &&
        other.handcraft_image == handcraft_image &&
        other.maker == maker &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        handcraft_count.hashCode ^
        handcraft_name.hashCode ^
        handcraft_price.hashCode ^
        handcraft_image.hashCode ^
        maker.hashCode ^
        category.hashCode;
  }
}
