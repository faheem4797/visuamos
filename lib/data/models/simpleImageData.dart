import 'dart:convert';

class SimpleImageData {
  final int? id;
  final String name;
  final String amount;
  final String date;
  final String coupon;
  final int imageType;
  SimpleImageData({
    this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.coupon,
    required this.imageType,
  });

  SimpleImageData copyWith({
    int? id,
    String? name,
    String? amount,
    String? date,
    String? coupon,
    int? imageType,
  }) {
    return SimpleImageData(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      coupon: coupon ?? this.coupon,
      imageType: imageType ?? this.imageType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date,
      'coupon': coupon,
      'imageType': imageType,
    };
  }

  factory SimpleImageData.fromMap(Map<String, dynamic> map) {
    return SimpleImageData(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      amount: map['amount'].toString(),
      date: map['date'] ?? '',
      coupon: map['coupon'] ?? '',
      imageType: map['imageType']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleImageData.fromJson(String source) =>
      SimpleImageData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SimpleImageData(id: $id, name: $name, amount: $amount, date: $date, coupon: $coupon, imageType: $imageType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SimpleImageData && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
