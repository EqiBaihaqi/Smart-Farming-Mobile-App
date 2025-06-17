// To parse this JSON data, do
//
//     final sensorReadingResponseModel = sensorReadingResponseModelFromJson(jsonString);

import 'dart:convert';

SensorReadingResponseModel sensorReadingResponseModelFromJson(String str) =>
    SensorReadingResponseModel.fromJson(json.decode(str));

String sensorReadingResponseModelToJson(SensorReadingResponseModel data) =>
    json.encode(data.toJson());

class SensorReadingResponseModel {
  Data data;
  int statusCode;
  String message;

  SensorReadingResponseModel({
    required this.data,
    required this.statusCode,
    required this.message,
  });

  factory SensorReadingResponseModel.fromJson(Map<String, dynamic> json) =>
      SensorReadingResponseModel(
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
  Dht dht;
  Npk npk1;
  Npk npk2;

  Data({required this.dht, required this.npk1, required this.npk2});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dht: Dht.fromJson(json["dht"]),
    npk1: Npk.fromJson(json["npk1"]),
    npk2: Npk.fromJson(json["npk2"]),
  );

  Map<String, dynamic> toJson() => {
    "dht": dht.toJson(),
    "npk1": npk1.toJson(),
    "npk2": npk2.toJson(),
  };
}

class Dht {
  num humidity;
  num luminosity;
  num temperature;

  Dht({
    required this.humidity,
    required this.luminosity,
    required this.temperature,
  });

  factory Dht.fromJson(Map<String, dynamic> json) => Dht(
    humidity: json["humidity"]?.toDouble(),
    luminosity: json["luminosity"]?.toDouble(),
    temperature: json["temperature"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "humidity": humidity,
    "luminosity": luminosity,
    "temperature": temperature,
  };
}

class Npk {
  num ph;
  num humidity;
  num nitrogen;
  num potassium;
  num phosphorus;
  num temperature;
  num conductivity;

  Npk({
    required this.ph,
    required this.humidity,
    required this.nitrogen,
    required this.potassium,
    required this.phosphorus,
    required this.temperature,
    required this.conductivity,
  });

  factory Npk.fromJson(Map<String, dynamic> json) => Npk(
    ph: json["ph"]?.toDouble(),
    humidity: json["humidity"],
    nitrogen: json["nitrogen"],
    potassium: json["potassium"],
    phosphorus: json["phosphorus"],
    temperature: json["temperature"],
    conductivity: json["conductivity"],
  );

  Map<String, dynamic> toJson() => {
    "ph": ph,
    "humidity": humidity,
    "nitrogen": nitrogen,
    "potassium": potassium,
    "phosphorus": phosphorus,
    "temperature": temperature,
    "conductivity": conductivity,
  };
}
