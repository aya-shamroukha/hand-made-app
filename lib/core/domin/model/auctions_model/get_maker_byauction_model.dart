// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Maker {
  final dynamic maker_id;
  final GetMakerByAuctionModel maker_details;
  Maker({
    required this.maker_id,
    required this.maker_details,
  });

  Maker copyWith({
    dynamic? maker_id,
    GetMakerByAuctionModel? maker_details,
  }) {
    return Maker(
      maker_id: maker_id ?? this.maker_id,
      maker_details: maker_details ?? this.maker_details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maker_id': maker_id,
      'maker_details': maker_details.toMap(),
    };
  }

  factory Maker.fromMap(Map<String, dynamic> map) {
    return Maker(
      maker_id: map['maker_id'] as dynamic,
      maker_details: GetMakerByAuctionModel.fromMap(
          map['maker_details'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Maker.fromJson(String source) =>
      Maker.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Maker(maker_id: $maker_id, maker_details: $maker_details)';

  @override
  bool operator ==(covariant Maker other) {
    if (identical(this, other)) return true;

    return other.maker_id == maker_id && other.maker_details == maker_details;
  }

  @override
  int get hashCode => maker_id.hashCode ^ maker_details.hashCode;
}

class GetMakerByAuctionModel {
  final dynamic phone_number;
  final String telegram_id;
  final String image;
  final String username;
  final String email;
  GetMakerByAuctionModel({
    required this.phone_number,
    required this.telegram_id,
    required this.image,
    required this.username,
    required this.email,
  });

  GetMakerByAuctionModel copyWith({
    dynamic? phone_number,
    String? telegram_id,
    String? image,
    String? username,
    String? email,
  }) {
    return GetMakerByAuctionModel(
      phone_number: phone_number ?? this.phone_number,
      telegram_id: telegram_id ?? this.telegram_id,
      image: image ?? this.image,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone_number': phone_number,
      'telegram_id': telegram_id,
      'image': image,
      'username': username,
      'email': email,
    };
  }

  factory GetMakerByAuctionModel.fromMap(Map<String, dynamic> map) {
    return GetMakerByAuctionModel(
      phone_number: map['phone_number'] as dynamic,
      telegram_id: map['telegram_id'] as String,
      image: map['image'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetMakerByAuctionModel.fromJson(String source) =>
      GetMakerByAuctionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetMakerByAuctionModel(phone_number: $phone_number, telegram_id: $telegram_id, image: $image, username: $username, email: $email)';
  }

  @override
  bool operator ==(covariant GetMakerByAuctionModel other) {
    if (identical(this, other)) return true;

    return other.phone_number == phone_number &&
        other.telegram_id == telegram_id &&
        other.image == image &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode {
    return phone_number.hashCode ^
        telegram_id.hashCode ^
        image.hashCode ^
        username.hashCode ^
        email.hashCode;
  }
}
