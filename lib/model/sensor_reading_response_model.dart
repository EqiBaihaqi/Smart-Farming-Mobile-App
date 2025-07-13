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
  Dht? dht;
  Npk? npk1;
  Npk? npk2;

  Data({required this.dht, required this.npk1, required this.npk2});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dht: Dht.fromJson(json["dht"]),
    npk1: Npk.fromJson(json["npk1"]),
    npk2: Npk.fromJson(json["npk2"]),
  );

  Map<String, dynamic> toJson() => {
    "dht": dht?.toJson(),
    "npk1": npk1?.toJson(),
    "npk2": npk2?.toJson(),
  };
}

class Dht {
  int? humidity;
  int? luminosity;
  int? temperature;

  Dht({
    required this.humidity,
    required this.luminosity,
    required this.temperature,
  });

  factory Dht.fromJson(Map<String, dynamic> json) => Dht(
    humidity: json["viciHumidity"] ?? 0,
    luminosity: json["viciLuminosity"] ?? 0,
    temperature: json["viciTemperature"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "humidity": humidity,
    "luminosity": luminosity,
    "temperature": temperature,
  };
}

class Npk {
  int? ph;
  int? humidity;
  int? nitrogen;
  int? potassium;
  int? phosphorus;
  int? temperature;
  int? conductivity;

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
    ph: json["soilPh"] ?? 0,
    humidity: json["soilHumidity"] ?? 0,
    nitrogen: json["soilNitrogen"] ?? 0,
    potassium: json["soilPotassium"] ?? 0,
    phosphorus: json["soilPhosphorus"] ?? 0,
    temperature: json["soilTemperature"] ?? 0,
    conductivity: json["soilConductivity"] ?? 0,
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
