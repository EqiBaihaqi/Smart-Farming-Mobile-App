// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  Data? data;
  int? statusCode;
  String? message;

  LoginResponseModel({this.data, this.statusCode, this.message});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "statusCode": statusCode,
    "message": message,
  };
}

class Data {
  String? token;
  String? jwtToken;

  Data({this.token, this.jwtToken});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(token: json["token"], jwtToken: json["jwtToken"]);

  Map<String, dynamic> toJson() => {"token": token, "jwtToken": jwtToken};
}
