// To parse this JSON data, do
//
//     final sumitImageModel = sumitImageModelFromJson(jsonString);

import 'dart:convert';

class SumitImageModel {
  SumitImageModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory SumitImageModel.fromRawJson(String str) => SumitImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SumitImageModel.fromJson(Map<String, dynamic> json) => SumitImageModel(
    status: json["Status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "message": message,
  };
}
