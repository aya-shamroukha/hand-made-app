// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdaeteCommentModel {
  final int handcraft;
  final String date;
  final String time;
  final String description;
  UpdaeteCommentModel({
    required this.handcraft,
    required this.date,
    required this.time,
    required this.description,
  });

  UpdaeteCommentModel copyWith({
    int? handcraft,
    String? date,
    String? time,
    String? description,
  }) {
    return UpdaeteCommentModel(
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

  factory UpdaeteCommentModel.fromMap(Map<String, dynamic> map) {
    return UpdaeteCommentModel(
      handcraft: map['handcraft'] as int,
      date: map['date'] as String,
      time: map['time'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdaeteCommentModel.fromJson(String source) => UpdaeteCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UpdaeteCommentModel(handcraft: $handcraft, date: $date, time: $time, description: $description)';
  }

  @override
  bool operator ==(covariant UpdaeteCommentModel other) {
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
