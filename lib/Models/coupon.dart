// To parse this JSON data, do
//
//     final coupon = couponFromJson(jsonString);

import 'dart:convert';

class Coupon {
  Coupon({
    this.response,
    this.message,
  });

  String response;
  String message;

  factory Coupon.fromRawJson(String str) => Coupon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    response: json["response"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
  };
}
