// To parse this JSON data, do
//
//     final imageEditor = imageEditorFromJson(jsonString);

import 'dart:convert';

class ImageEditor {
  ImageEditor({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory ImageEditor.fromRawJson(String str) => ImageEditor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageEditor.fromJson(Map<String, dynamic> json) => ImageEditor(
    status: json["Status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "message": message,
  };
}
