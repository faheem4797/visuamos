import 'dart:convert';

class SimpleImageData {
  final int? id;
  final String uid;
  final String name;
  final String amount;
  final String date;
  final int isPaid;
  final String coupon;
  final int imageType;
  SimpleImageData({
    this.id,
    required this.uid,
    required this.name,
    required this.amount,
    required this.date,
    required this.isPaid,
    required this.coupon,
    required this.imageType,
  });

  SimpleImageData copyWith({
    int? id,
    String? uid,
    String? name,
    String? amount,
    String? date,
    int? isPaid,
    String? coupon,
    int? imageType,
  }) {
    return SimpleImageData(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isPaid: isPaid ?? this.isPaid,
      coupon: coupon ?? this.coupon,
      imageType: imageType ?? this.imageType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'amount': amount,
      'date': date,
      'isPaid': isPaid,
      'coupon': coupon,
      'imageType': imageType,
    };
  }

  factory SimpleImageData.fromMap(Map<String, dynamic> map) {
    return SimpleImageData(
      id: map['id']?.toInt(),
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      amount: map['amount']?.toString() ?? '',
      date: map['date'] ?? '',
      isPaid: map['isPaid']?.toInt() ?? 0,
      coupon: map['coupon'] ?? '',
      imageType: map['imageType']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleImageData.fromJson(String source) =>
      SimpleImageData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SimpleImageData(id: $id, uid: $uid, name: $name, amount: $amount, date: $date, isPaid: $isPaid, coupon: $coupon, imageType: $imageType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SimpleImageData &&
        other.id == id &&
        other.uid == uid &&
        other.name == name &&
        other.amount == amount &&
        other.date == date &&
        other.isPaid == isPaid &&
        other.coupon == coupon &&
        other.imageType == imageType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        name.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        isPaid.hashCode ^
        coupon.hashCode ^
        imageType.hashCode;
  }
}
