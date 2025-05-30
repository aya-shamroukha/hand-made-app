// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../categories_model/get_hand_craftdetail_model.dart';

class GetOrderModel {
  final int id;
  final String full_price;
  final String date_of_order;

  final String time_of_order;
  final bool delivery;
  final String customer_phone;
  final List<OrderHandCraft> orderhandcrafts;
  GetOrderModel({
    required this.id,
    required this.full_price,
    required this.date_of_order,
    required this.time_of_order,
    required this.delivery,
    required this.customer_phone,
    required this.orderhandcrafts,
  });

  GetOrderModel copyWith({
    int? id,
    String? full_price,
    String? date_of_order,
    String? time_of_order,
    bool? delivery,
    String? customer_phone,
    List<OrderHandCraft>? orderhandcrafts,
  }) {
    return GetOrderModel(
      id: id ?? this.id,
      full_price: full_price ?? this.full_price,
      date_of_order: date_of_order ?? this.date_of_order,
      time_of_order: time_of_order ?? this.time_of_order,
      delivery: delivery ?? this.delivery,
      customer_phone: customer_phone ?? this.customer_phone,
      orderhandcrafts: orderhandcrafts ?? this.orderhandcrafts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_price': full_price,
      'date_of_order': date_of_order,
      'time_of_order': time_of_order,
      'delivery': delivery,
      'customer_phone': customer_phone,
      'orderhandcrafts': orderhandcrafts.map((x) => x.toMap()).toList(),
    };
  }

  factory GetOrderModel.fromMap(Map<String, dynamic> map) {
    return GetOrderModel(
      id: map['id'] as int,
      full_price: map['full_price'] as String,
      date_of_order: map['date_of_order'] as String,
      time_of_order: map['time_of_order'] as String,
      delivery: map['delivery'] as bool,
      customer_phone: map['customer_phone'] as String,
      orderhandcrafts: List<OrderHandCraft>.from(
        (map['orderhandcrafts'] as List<dynamic>).map<OrderHandCraft>(
          (x) => OrderHandCraft.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetOrderModel.fromJson(String source) =>
      GetOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetOrderModel(id: $id, full_price: $full_price, date_of_order: $date_of_order, time_of_order: $time_of_order, delivery: $delivery, customer_phone: $customer_phone, orderhandcrafts: $orderhandcrafts)';
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
        orderhandcrafts.hashCode;
  }
}

class OrderHandCraft {
  final GetHandCraftdetailModel handcraft;
  final int quantity;
  final String price;
  OrderHandCraft({
    required this.handcraft,
    required this.quantity,
    required this.price,
  });
 

  OrderHandCraft copyWith({
    GetHandCraftdetailModel? handcraft,
    int? quantity,
    String? price,
  }) {
    return OrderHandCraft(
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

  factory OrderHandCraft.fromMap(Map<String, dynamic> map) {
    return OrderHandCraft(
      handcraft: GetHandCraftdetailModel.fromMap(map['handcraft'] as Map<String,dynamic>),
      quantity: map['quantity'] as int,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHandCraft.fromJson(String source) => OrderHandCraft.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderHandCraft(handcraft: $handcraft, quantity: $quantity, price: $price)';

  @override
  bool operator ==(covariant OrderHandCraft other) {
    if (identical(this, other)) return true;
  
    return 
      other.handcraft == handcraft &&
      other.quantity == quantity &&
      other.price == price;
  }

  @override
  int get hashCode => handcraft.hashCode ^ quantity.hashCode ^ price.hashCode;
}
