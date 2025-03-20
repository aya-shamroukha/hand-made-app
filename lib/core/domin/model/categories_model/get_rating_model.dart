// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetRatingModel {
  final double data;
  GetRatingModel({
    required this.data,
  });

  GetRatingModel copyWith({
    double? data,
  }) {
    return GetRatingModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
    };
  }

  factory GetRatingModel.fromMap(Map<String, dynamic> map) {
    return GetRatingModel(
      data: map['data'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetRatingModel.fromJson(String source) => GetRatingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetRatingModel(data: $data)';

  @override
  bool operator ==(covariant GetRatingModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
