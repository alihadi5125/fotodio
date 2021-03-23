// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

class Response {
  Response({
    this.response,
    this.message,
  });

  String response;
  String message;

  factory Response.fromRawJson(String str) => Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    response: json["response"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
  };
}
