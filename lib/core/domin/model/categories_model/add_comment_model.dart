// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddCommentModel {
  final dynamic handcraft;
  final String date;
    final String time;
  final String description;
  AddCommentModel({
    required this.handcraft,
    required this.date,
    required this.time,
    required this.description,
  });



  AddCommentModel copyWith({
    int? handcraft,
    String? date,
    String? time,
    String? description,
  }) {
    return AddCommentModel(
      handcraft: handcraft ?? this.handcraft,
      date: date ?? this.date,
      time: time ?? this.time,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'handcraft': handcraft,
      'date': date,
      'time': time,
      'description': description,
    };
  }

  factory AddCommentModel.fromMap(Map<String, dynamic> map) {
    return AddCommentModel(
      handcraft: map['handcraft'] as int,
      date: map['date'] as String,
      time: map['time'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCommentModel.fromJson(String source) => AddCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddCommentModel(handcraft: $handcraft, date: $date, time: $time, description: $description)';
  }

  @override
  bool operator ==(covariant AddCommentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.handcraft == handcraft &&
      other.date == date &&
      other.time == time &&
      other.description == description;
  }

  @override
  int get hashCode {
    return handcraft.hashCode ^
      date.hashCode ^
      time.hashCode ^
      description.hashCode;
  }
}
