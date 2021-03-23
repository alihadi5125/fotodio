// To parse this JSON data, do
//
//     final sizeModel = sizeModelFromJson(jsonString);

import 'dart:convert';

class SizeModel {
  SizeModel({
    this.response,
    this.message,
    this.data,
    this.deliverycharges,
  });

  String response;
  String message;
  List<Datum> data;
  List<Deliverycharge> deliverycharges;

  factory SizeModel.fromRawJson(String str) => SizeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
    response: json["response"],
    message: json["message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
    deliverycharges: List<Deliverycharge>.from(json["deliverycharges"].map((x) => Deliverycharge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    "deliverycharges": List<dynamic>.from(deliverycharges.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.studioId,
    this.imgSize,
    this.totalcost,
  });

  int id;
  int studioId;
  String imgSize;
  String totalcost;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    studioId: json["studioID"],
    imgSize: json["ImgSize"],
    totalcost: json["totalcost"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "studioID": studioId,
    "ImgSize": imgSize,
    "totalcost": totalcost,
  };
}

class Deliverycharge {
  Deliverycharge({
    this.deliveryCharges,
  });

  String deliveryCharges;

  factory Deliverycharge.fromRawJson(String str) => Deliverycharge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Deliverycharge.fromJson(Map<String, dynamic> json) => Deliverycharge(
    deliveryCharges: json["DeliveryCharges"],
  );

  Map<String, dynamic> toJson() => {
    "DeliveryCharges": deliveryCharges,
  };
}
