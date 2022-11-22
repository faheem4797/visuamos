import 'dart:convert';

class DreamMovieData {
  final int? id;
  final String uid;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
  final String image9;
  final String image10;
  final String caption1;
  final String caption2;
  final String caption3;
  final String caption4;
  final String caption5;
  final String caption6;
  final String caption7;
  final String caption8;
  final String caption9;
  final String caption10;
  final String audio;
  final int isPaid;
  final String coupon;
  DreamMovieData({
    this.id,
    required this.uid,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.image6,
    required this.image7,
    required this.image8,
    required this.image9,
    required this.image10,
    required this.caption1,
    required this.caption2,
    required this.caption3,
    required this.caption4,
    required this.caption5,
    required this.caption6,
    required this.caption7,
    required this.caption8,
    required this.caption9,
    required this.caption10,
    required this.audio,
    required this.isPaid,
    required this.coupon,
  });

  DreamMovieData copyWith({
    int? id,
    String? uid,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? image5,
    String? image6,
    String? image7,
    String? image8,
    String? image9,
    String? image10,
    String? caption1,
    String? caption2,
    String? caption3,
    String? caption4,
    String? caption5,
    String? caption6,
    String? caption7,
    String? caption8,
    String? caption9,
    String? caption10,
    String? audio,
    int? isPaid,
    String? coupon,
  }) {
    return DreamMovieData(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      image3: image3 ?? this.image3,
      image4: image4 ?? this.image4,
      image5: image5 ?? this.image5,
      image6: image6 ?? this.image6,
      image7: image7 ?? this.image7,
      image8: image8 ?? this.image8,
      image9: image9 ?? this.image9,
      image10: image10 ?? this.image10,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
      caption3: caption3 ?? this.caption3,
      caption4: caption4 ?? this.caption4,
      caption5: caption5 ?? this.caption5,
      caption6: caption6 ?? this.caption6,
      caption7: caption7 ?? this.caption7,
      caption8: caption8 ?? this.caption8,
      caption9: caption9 ?? this.caption9,
      caption10: caption10 ?? this.caption10,
      audio: audio ?? this.audio,
      isPaid: isPaid ?? this.isPaid,
      coupon: coupon ?? this.coupon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'image5': image5,
      'image6': image6,
      'image7': image7,
      'image8': image8,
      'image9': image9,
      'image10': image10,
      'caption1': caption1,
      'caption2': caption2,
      'caption3': caption3,
      'caption4': caption4,
      'caption5': caption5,
      'caption6': caption6,
      'caption7': caption7,
      'caption8': caption8,
      'caption9': caption9,
      'caption10': caption10,
      'audio': audio,
      'isPaid': isPaid,
      'coupon': coupon,
    };
  }

  factory DreamMovieData.fromMap(Map<String, dynamic> map) {
    return DreamMovieData(
      id: map['id']?.toInt(),
      uid: map['uid'] ?? '',
      image1: map['image1'] ?? '',
      image2: map['image2'] ?? '',
      image3: map['image3'] ?? '',
      image4: map['image4'] ?? '',
      image5: map['image5'] ?? '',
      image6: map['image6'] ?? '',
      image7: map['image7'] ?? '',
      image8: map['image8'] ?? '',
      image9: map['image9'] ?? '',
      image10: map['image10'] ?? '',
      caption1: map['caption1'] ?? '',
      caption2: map['caption2'] ?? '',
      caption3: map['caption3'] ?? '',
      caption4: map['caption4'] ?? '',
      caption5: map['caption5'] ?? '',
      caption6: map['caption6'] ?? '',
      caption7: map['caption7'] ?? '',
      caption8: map['caption8'] ?? '',
      caption9: map['caption9'] ?? '',
      caption10: map['caption10'] ?? '',
      audio: map['audio'] ?? '',
      isPaid: map['isPaid']?.toInt() ?? 0,
      coupon: map['coupon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DreamMovieData.fromJson(String source) =>
      DreamMovieData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DreamMovieData(id: $id, uid: $uid, image1: $image1, image2: $image2, image3: $image3, image4: $image4, image5: $image5, image6: $image6, image7: $image7, image8: $image8, image9: $image9, image10: $image10, caption1: $caption1, caption2: $caption2, caption3: $caption3, caption4: $caption4, caption5: $caption5, caption6: $caption6, caption7: $caption7, caption8: $caption8, caption9: $caption9, caption10: $caption10, audio: $audio, isPaid: $isPaid, coupon: $coupon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DreamMovieData &&
        other.id == id &&
        other.uid == uid &&
        other.image1 == image1 &&
        other.image2 == image2 &&
        other.image3 == image3 &&
        other.image4 == image4 &&
        other.image5 == image5 &&
        other.image6 == image6 &&
        other.image7 == image7 &&
        other.image8 == image8 &&
        other.image9 == image9 &&
        other.image10 == image10 &&
        other.caption1 == caption1 &&
        other.caption2 == caption2 &&
        other.caption3 == caption3 &&
        other.caption4 == caption4 &&
        other.caption5 == caption5 &&
        other.caption6 == caption6 &&
        other.caption7 == caption7 &&
        other.caption8 == caption8 &&
        other.caption9 == caption9 &&
        other.caption10 == caption10 &&
        other.audio == audio &&
        other.isPaid == isPaid &&
        other.coupon == coupon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        image1.hashCode ^
        image2.hashCode ^
        image3.hashCode ^
        image4.hashCode ^
        image5.hashCode ^
        image6.hashCode ^
        image7.hashCode ^
        image8.hashCode ^
        image9.hashCode ^
        image10.hashCode ^
        caption1.hashCode ^
        caption2.hashCode ^
        caption3.hashCode ^
        caption4.hashCode ^
        caption5.hashCode ^
        caption6.hashCode ^
        caption7.hashCode ^
        caption8.hashCode ^
        caption9.hashCode ^
        caption10.hashCode ^
        audio.hashCode ^
        isPaid.hashCode ^
        coupon.hashCode;
  }
}
