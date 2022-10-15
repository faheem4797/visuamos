import 'dart:convert';
import 'dart:typed_data';

class VisionBoardData {
  final int? id;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
  final String fileName;
  VisionBoardData({
    this.id,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.image6,
    required this.image7,
    required this.image8,
    required this.fileName,
  });

  VisionBoardData copyWith({
    int? id,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? image5,
    String? image6,
    String? image7,
    String? image8,
    String? fileName,
  }) {
    return VisionBoardData(
      id: id ?? this.id,
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      image3: image3 ?? this.image3,
      image4: image4 ?? this.image4,
      image5: image5 ?? this.image5,
      image6: image6 ?? this.image6,
      image7: image7 ?? this.image7,
      image8: image8 ?? this.image8,
      fileName: fileName ?? this.fileName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'image5': image5,
      'image6': image6,
      'image7': image7,
      'image8': image8,
      'fileName': fileName,
    };
  }

  factory VisionBoardData.fromMap(Map<String, dynamic> map) {
    return VisionBoardData(
      id: map['id']?.toInt(),
      image1: map['image1'] ?? '',
      image2: map['image2'] ?? '',
      image3: map['image3'] ?? '',
      image4: map['image4'] ?? '',
      image5: map['image5'] ?? '',
      image6: map['image6'] ?? '',
      image7: map['image7'] ?? '',
      image8: map['image8'] ?? '',
      fileName: map['fileName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VisionBoardData.fromJson(String source) =>
      VisionBoardData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VisionBoardData(id: $id, image1: $image1, image2: $image2, image3: $image3, image4: $image4, image5: $image5, image6: $image6, image7: $image7, image8: $image8, fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VisionBoardData &&
        other.id == id &&
        other.image1 == image1 &&
        other.image2 == image2 &&
        other.image3 == image3 &&
        other.image4 == image4 &&
        other.image5 == image5 &&
        other.image6 == image6 &&
        other.image7 == image7 &&
        other.image8 == image8 &&
        other.fileName == fileName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image1.hashCode ^
        image2.hashCode ^
        image3.hashCode ^
        image4.hashCode ^
        image5.hashCode ^
        image6.hashCode ^
        image7.hashCode ^
        image8.hashCode ^
        fileName.hashCode;
  }
}
