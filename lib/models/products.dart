import 'package:cloud_firestore/cloud_firestore.dart';

class Productz {
  String company;
  int price;
  List<int> size;
  String title;
  String image;

  Productz({
    required this.company,
    required this.price,
    required this.size,
    required this.title,
    required this.image,
  });

  Map<String, Object?> toJson() {
    return {
      'company': company,
      'price': price,
      'size': size,
      'title': title,
      'imageUrl': image,
    };
  }

  Productz.fromJson(Map<String, Object?> json)
      : this(
          company: json['company']! as String,
          price: json['price']! as int,
          size: json['size'] as List<int>,
          // ).map((e) => e as int).toList() ??
          //     [],
          title: json['title']! as String,
          image: json['imageUrl']! as String,
        );

  Productz copyWith(
      {String? company,
      int? price,
      List<int>? size,
      String? title,
      String? image}) {
    return Productz(
      company: company ?? this.company,
      price: price ?? this.price,
      size: size ?? this.size,
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }
}
