import 'dart:convert';

import 'package:flutter/foundation.dart';

// // ignore_for_file: public_member_api_docs, sort_constructors_first

class GetOrderModel {
  final int id;
  final String full_price;
  final dynamic date_of_order;
  final String time_of_order;
  final bool delivery;
  final String customer_phone;
  final int customer;
  final dynamic orderhandcrafts;
  GetOrderModel({
    required this.id,
    required this.full_price,
    required this.date_of_order,
    required this.time_of_order,
    required this.delivery,
    required this.customer_phone,
    required this.customer,
    required this.orderhandcrafts,
  });

  GetOrderModel copyWith({
    int? id,
    String? full_price,
    DateTime? date_of_order,
    String? time_of_order,
    bool? delivery,
    String? customer_phone,
    int? customer,
    List<Orderhandcraft>? orderhandcrafts,
  }) {
    return GetOrderModel(
      id: id ?? this.id,
      full_price: full_price ?? this.full_price,
      date_of_order: date_of_order ?? this.date_of_order,
      time_of_order: time_of_order ?? this.time_of_order,
      delivery: delivery ?? this.delivery,
      customer_phone: customer_phone ?? this.customer_phone,
      customer: customer ?? this.customer,
      orderhandcrafts: orderhandcrafts ?? this.orderhandcrafts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_price': full_price,
      'date_of_order': date_of_order.millisecondsSinceEpoch,
      'time_of_order': time_of_order,
      'delivery': delivery,
      'customer_phone': customer_phone,
      'customer': customer,
      'orderhandcrafts': orderhandcrafts.map((x) => x.toMap()).toList(),
    };
  }

  factory GetOrderModel.fromMap(Map<String, dynamic> map) {
    return GetOrderModel(
      id: map['id'] as int? ?? 0,
      full_price: map['full_price']?.toString() ?? '',
      date_of_order:
          DateTime.fromMillisecondsSinceEpoch(map['date_of_order'] as int? ?? 0),
      time_of_order: map['time_of_order']?.toString() ?? '',
      delivery: map['delivery'] as bool,
      customer_phone: map['customer_phone']?.toString() ?? '',
      customer: map['customer'] as int? ?? 0,
      orderhandcrafts: List<Orderhandcraft>.from(
        (map['orderhandcrafts'] as List<dynamic>? ?? []).map<Orderhandcraft>(
          (x) => Orderhandcraft.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetOrderModel.fromJson(String source) =>
      GetOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetOrderModel(id: $id, full_price: $full_price, date_of_order: $date_of_order, time_of_order: $time_of_order, delivery: $delivery, customer_phone: $customer_phone, customer: $customer, orderhandcrafts: $orderhandcrafts)';
  }

  @override
  bool operator ==(covariant GetOrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.full_price == full_price &&
        other.date_of_order == date_of_order &&
        other.time_of_order == time_of_order &&
        other.delivery == delivery &&
        other.customer_phone == customer_phone &&
        other.customer == customer &&
        listEquals(other.orderhandcrafts, orderhandcrafts);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        full_price.hashCode ^
        date_of_order.hashCode ^
        time_of_order.hashCode ^
        delivery.hashCode ^
        customer_phone.hashCode ^
        customer.hashCode ^
        orderhandcrafts.hashCode;
  }
}

class Orderhandcraft {
  final Handcraft handcraft;
  final int quantity;
  final String price;
  Orderhandcraft({
    required this.handcraft,
    required this.quantity,
    required this.price,
  });

  Orderhandcraft copyWith({
    Handcraft? handcraft,
    int? quantity,
    String? price,
  }) {
    return Orderhandcraft(
      handcraft: handcraft ?? this.handcraft,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'handcraft': handcraft.toMap(),
      'quantity': quantity,
      'price': price,
    };
  }

  factory Orderhandcraft.fromMap(Map<String, dynamic> map) {
    return Orderhandcraft(
      handcraft: Handcraft.fromMap(map['handcraft'] as Map<String, dynamic>),
      quantity: map['quantity'] as int? ?? 0,
      price: map['price']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Orderhandcraft.fromJson(String source) =>
      Orderhandcraft.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Orderhandcraft(handcraft: $handcraft, quantity: $quantity, price: $price)';

  @override
  bool operator ==(covariant Orderhandcraft other) {
    if (identical(this, other)) return true;

    return other.handcraft == handcraft &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode => handcraft.hashCode ^ quantity.hashCode ^ price.hashCode;
}

class Handcraft {
  final int id;
  final String handcraft_name;
  final String handcraft_price;
  final int handcraft_count;
  final String handcraft_image;
  final int category;
  final int maker;
  Handcraft({
    required this.id,
    required this.handcraft_name,
    required this.handcraft_price,
    required this.handcraft_count,
    required this.handcraft_image,
    required this.category,
    required this.maker,
  });

  Handcraft copyWith({
    int? id,
    String? handcraft_name,
    String? handcraft_price,
    int? handcraft_count,
    String? handcraft_image,
    int? category,
    int? maker,
  }) {
    return Handcraft(
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

  factory Handcraft.fromMap(Map<String, dynamic> map) {
    return Handcraft(
      id: map['id'] as int? ?? 0,
      handcraft_name: map['handcraft_name']?.toString() ?? '',
      handcraft_price: map['handcraft_price']?.toString() ?? '',
      handcraft_count: map['handcraft_count'] as int? ?? 0,
      handcraft_image: map['handcraft_image']?.toString() ?? '',
      category: map['category'] as int? ?? 0,
      maker: map['maker'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Handcraft.fromJson(String source) =>
      Handcraft.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Handcraft(id: $id, handcraft_name: $handcraft_name, handcraft_price: $handcraft_price, handcraft_count: $handcraft_count, handcraft_image: $handcraft_image, category: $category, maker: $maker)';
  }

  @override
  bool operator ==(covariant Handcraft other) {
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
