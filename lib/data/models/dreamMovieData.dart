import 'dart:convert';

class DreamMovieData {
  final int? id;
  final String image1;
  final String image2;
  final String image3;
  final String caption1;
  final String caption2;
  final String caption3;
  final String audio;
  DreamMovieData({
    this.id,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.caption1,
    required this.caption2,
    required this.caption3,
    required this.audio,
  });

  DreamMovieData copyWith({
    int? id,
    String? image1,
    String? image2,
    String? image3,
    String? caption1,
    String? caption2,
    String? caption3,
    String? audio,
  }) {
    return DreamMovieData(
      id: id ?? this.id,
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      image3: image3 ?? this.image3,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
      caption3: caption3 ?? this.caption3,
      audio: audio ?? this.audio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'caption1': caption1,
      'caption2': caption2,
      'caption3': caption3,
      'audio': audio,
    };
  }

  factory DreamMovieData.fromMap(Map<String, dynamic> map) {
    return DreamMovieData(
      id: map['id']?.toInt(),
      image1: map['image1'] ?? '',
      image2: map['image2'] ?? '',
      image3: map['image3'] ?? '',
      caption1: map['caption1'] ?? '',
      caption2: map['caption2'] ?? '',
      caption3: map['caption3'] ?? '',
      audio: map['audio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DreamMovieData.fromJson(String source) =>
      DreamMovieData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DreamMovieData(id: $id, image1: $image1, image2: $image2, image3: $image3, caption1: $caption1, caption2: $caption2, caption3: $caption3, audio: $audio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DreamMovieData &&
        other.id == id &&
        other.image1 == image1 &&
        other.image2 == image2 &&
        other.image3 == image3 &&
        other.caption1 == caption1 &&
        other.caption2 == caption2 &&
        other.caption3 == caption3 &&
        other.audio == audio;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image1.hashCode ^
        image2.hashCode ^
        image3.hashCode ^
        caption1.hashCode ^
        caption2.hashCode ^
        caption3.hashCode ^
        audio.hashCode;
  }
}
