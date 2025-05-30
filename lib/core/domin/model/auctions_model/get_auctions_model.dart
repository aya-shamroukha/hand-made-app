// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetAuctionsModel {
  final int id;
  final String name;
    final String location;
      final String description;
        final String from_date;
          final String to_date;
  GetAuctionsModel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.from_date,
    required this.to_date,
  });

  GetAuctionsModel copyWith({
    int? id,
    String? name,
    String? location,
    String? description,
    String? from_date,
    String? to_date,
  }) {
    return GetAuctionsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      from_date: from_date ?? this.from_date,
      to_date: to_date ?? this.to_date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'from_date': from_date,
      'to_date': to_date,
    };
  }

  factory GetAuctionsModel.fromMap(Map<String, dynamic> map) {
    return GetAuctionsModel(
      id: map['id'] as int,
      name: map['name'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      from_date: map['from_date'] as String,
      to_date: map['to_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAuctionsModel.fromJson(String source) => GetAuctionsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetAuctionsModel(id: $id, name: $name, location: $location, description: $description, from_date: $from_date, to_date: $to_date)';
  }

  @override
  bool operator ==(covariant GetAuctionsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.location == location &&
      other.description == description &&
      other.from_date == from_date &&
      other.to_date == to_date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      location.hashCode ^
      description.hashCode ^
      from_date.hashCode ^
      to_date.hashCode;
  }
}
