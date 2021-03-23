// To parse this JSON data, do
//
//     final sponsorImage = sponsorImageFromJson(jsonString);

import 'dart:convert';

class SponsorImage {
  SponsorImage({
    this.response,
    this.message,
    this.data,
  });

  String response;
  String message;
  List<Datum> data;

  factory SponsorImage.fromRawJson(String str) => SponsorImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SponsorImage.fromJson(Map<String, dynamic> json) => SponsorImage(
    response: json["response"],
    message: json["message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.sponsor,
    this.imgSize,
    this.imagepath,
    this.discount,
    this.totalsponsored,
    this.consumed,
  });

  int id;
  String sponsor;
  String imgSize;
  String imagepath;
  String discount;
  String totalsponsored;
  String consumed;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    sponsor: json["sponsor"],
    imgSize: json["ImgSize"],
    imagepath: json["imagepath"],
    discount: json["discount"],
    totalsponsored: json["totalsponsored"],
    consumed: json["consumed"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "sponsor": sponsor,
    "ImgSize": imgSize,
    "imagepath": imagepath,
    "discount": discount,
    "totalsponsored": totalsponsored,
    "consumed": consumed,
  };
}