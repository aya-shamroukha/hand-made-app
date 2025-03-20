// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class AiModel {
  final dynamic sofa_image;
  final dynamic pillow_image;
  AiModel({
    required this.sofa_image,
    required this.pillow_image,
  });
  Map<String, dynamic> toMultipartData() {
    return {
      'sofa_image': sofa_image,
      'pillow_image': pillow_image,
    };
  }

  AiModel copyWith({
    dynamic sofa_image,
    dynamic pillow_image,
  }) {
    return AiModel(
      sofa_image: sofa_image ?? this.sofa_image,
      pillow_image: pillow_image ?? this.pillow_image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sofa_image': sofa_image,
      'pillow_image': pillow_image,
    };
  }

  factory AiModel.fromMap(Map<String, dynamic> map) {
    return AiModel(
      sofa_image: map['sofa_image'] as dynamic,
      pillow_image: map['pillow_image'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory AiModel.fromJson(String source) =>
      AiModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AiModel(sofa_image: $sofa_image, pillow_image: $pillow_image)';

  @override
  bool operator ==(covariant AiModel other) {
    if (identical(this, other)) return true;

    return other.sofa_image == sofa_image && other.pillow_image == pillow_image;
  }

  @override
  int get hashCode => sofa_image.hashCode ^ pillow_image.hashCode;
}
