import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orderz {
  String address;
  Timestamp orderTime;
  List<Map<String, Object>> productz;
  int total;

  Orderz({
    required this.address,
    required this.orderTime,
    required this.productz,
    required this.total,
  });

  Map<String, Object?> toJson() {
    return {
      'address': address,
      'orderTime': orderTime,
      'products': productz,
      'total': total
    };
  }

  Orderz.fromJson(Map<String, Object?> json)
      : this(
          address: json['address']! as String,
          orderTime: json['orderTime']! as Timestamp,
          productz: json['products']! as List<Map<String, Object>>,
          total: json['total']! as int,
        );

  Orderz copyWith({
    String? address,
    Timestamp? orderTime,
    List<Map<String, Object>>? productz,
    int? total,
  }) {
    return Orderz(
      address: address ?? this.address,
      orderTime: orderTime ?? this.orderTime,
      productz: productz ?? this.productz,
      total: total ?? this.total,
    );
  }
}
