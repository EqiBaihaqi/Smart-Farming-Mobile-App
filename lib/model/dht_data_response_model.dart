// To parse this JSON data, do
//
//     final dhtDataResponseModel = dhtDataResponseModelFromJson(jsonString);

import 'dart:convert';

DhtDataResponseModel dhtDataResponseModelFromJson(String str) =>
    DhtDataResponseModel.fromJson(json.decode(str));

String dhtDataResponseModelToJson(DhtDataResponseModel data) =>
    json.encode(data.toJson());

class DhtDataResponseModel {
  Data data;
  int statusCode;
  String message;

  DhtDataResponseModel({
    required this.data,
    required this.statusCode,
    required this.message,
  });

  factory DhtDataResponseModel.fromJson(Map<String, dynamic> json) =>
      DhtDataResponseModel(
        data: Data.fromJson(json["data"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "statusCode": statusCode,
    "message": message,
  };
}

class Data {
  List<Dht> dht;

  Data({required this.dht});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(dht: List<Dht>.from(json["dht"].map((x) => Dht.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "dht": List<dynamic>.from(dht.map((x) => x.toJson())),
  };
}

class Dht {
  int hour;
  DateTime date;
  double vicitemperature;
  double vicihumidity;
  int viciluminosity;

  Dht({
    required this.hour,
    required this.date,
    required this.vicitemperature,
    required this.vicihumidity,
    required this.viciluminosity,
  });

  factory Dht.fromJson(Map<String, dynamic> json) => Dht(
    hour: json["hour"],
    date: DateTime.parse(json["date"]),
    vicitemperature: json["vicitemperature"]?.toDouble(),
    vicihumidity: json["vicihumidity"]?.toDouble(),
    viciluminosity: json["viciluminosity"],
  );

  Map<String, dynamic> toJson() => {
    "hour": hour,
    "date":
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "vicitemperature": vicitemperature,
    "vicihumidity": vicihumidity,
    "viciluminosity": viciluminosity,
  };
}
