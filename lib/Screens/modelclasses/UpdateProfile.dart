// To parse this JSON data, do
//
//     final updateProfile = updateProfileFromJson(jsonString);

import 'dart:convert';

class UpdateProfile {
  UpdateProfile({
    this.status,
    this.message,
    this.user,
  });

  String status;
  String message;
  List<User> user;

  factory UpdateProfile.fromRawJson(String str) => UpdateProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
    status: json["Status"],
    message: json["message"],
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "message": message,
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.userId,
    this.fName,
    this.lName,
    this.email,
    this.mobile,
    this.country,
    this.city,
    this.address,
  });

  int userId;
  String fName;
  dynamic lName;
  String email;
  String mobile;
  String country;
  String city;
  String address;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userID"],
    fName: json["f_Name"],
    lName: json["l_Name"],
    email: json["email"],
    mobile: json["mobile"],
    country: json["country"],
    city: json["city"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userId,
    "f_Name": fName,
    "l_Name": lName,
    "email": email,
    "mobile": mobile,
    "country": country,
    "city": city,
    "address": address,
  };
}
