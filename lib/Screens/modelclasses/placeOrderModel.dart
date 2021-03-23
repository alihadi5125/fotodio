// To parse this JSON data, do
//
//     final placeOrder = placeOrderFromJson(jsonString);

import 'dart:convert';

class PlaceOrder {
  PlaceOrder({
    this.status,
    this.message,
    this.order,
  });

  String status;
  String message;
  Order order;

  factory PlaceOrder.fromRawJson(String str) => PlaceOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceOrder.fromJson(Map<String, dynamic> json) => PlaceOrder(
    status: json["Status"],
    message: json["message"],
    order: Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "message": message,
    "order": order.toJson(),
  };
}

class Order {
  Order({
    this.customerId,
    this.name,
    this.email,
    this.phone,
    this.shippingAddress,
    this.zipCode,
    this.city,
    this.country,
    this.totalbill,
  });

  String customerId;
  String name;
  dynamic email;
  String phone;
  String shippingAddress;
  String zipCode;
  String city;
  String country;
  String totalbill;

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    customerId: json["customerID"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    shippingAddress: json["shipping_address"],
    zipCode: json["zip_code"],
    city: json["city"],
    country: json["country"],
    totalbill: json["totalbill"],
  );

  Map<String, dynamic> toJson() => {
    "customerID": customerId,
    "name": name,
    "email": email,
    "phone": phone,
    "shipping_address": shippingAddress,
    "zip_code": zipCode,
    "city": city,
    "country": country,
    "totalbill": totalbill,
  };
}
