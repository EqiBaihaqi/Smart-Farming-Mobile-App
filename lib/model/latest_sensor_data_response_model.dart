// To parse this JSON data, do
//
//     final latestSensorDataResponseModel = latestSensorDataResponseModelFromJson(jsonString);

import 'dart:convert';

LatestSensorDataResponseModel latestSensorDataResponseModelFromJson(String str) => LatestSensorDataResponseModel.fromJson(json.decode(str));

String latestSensorDataResponseModelToJson(LatestSensorDataResponseModel data) => json.encode(data.toJson());

class LatestSensorDataResponseModel {
    Data? data;
    int? statusCode;
    String? message;

    LatestSensorDataResponseModel({
        this.data,
        this.statusCode,
        this.message,
    });

    factory LatestSensorDataResponseModel.fromJson(Map<String, dynamic> json) => LatestSensorDataResponseModel(
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
    Dht? dht;
    Npk? npk1;
    Npk? npk2;

    Data({
        this.dht,
        this.npk1,
        this.npk2,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        dht: json["dht"] == null ? null : Dht.fromJson(json["dht"]),
        npk1: json["npk1"] == null ? null : Npk.fromJson(json["npk1"]),
        npk2: json["npk2"] == null ? null : Npk.fromJson(json["npk2"]),
    );

    Map<String, dynamic> toJson() => {
        "dht": dht?.toJson(),
        "npk1": npk1?.toJson(),
        "npk2": npk2?.toJson(),
    };
}

class Dht {
    double? vicitemperature;
    double? vicihumidity;
    int? viciluminosity;

    Dht({
        this.vicitemperature,
        this.vicihumidity,
        this.viciluminosity,
    });

    factory Dht.fromJson(Map<String, dynamic> json) => Dht(
        vicitemperature: json["vicitemperature"]?.toDouble(),
        vicihumidity: json["vicihumidity"]?.toDouble(),
        viciluminosity: json["viciluminosity"],
    );

    Map<String, dynamic> toJson() => {
        "vicitemperature": vicitemperature,
        "vicihumidity": vicihumidity,
        "viciluminosity": viciluminosity,
    };
}

class Npk {
    int? soiltemperature;
    int? soilhumidity;
    int? soilconductivity;
    int? soilph;
    int? soilnitrogen;
    int? soilphosphorus;
    int? soilpotassium;

    Npk({
        this.soiltemperature,
        this.soilhumidity,
        this.soilconductivity,
        this.soilph,
        this.soilnitrogen,
        this.soilphosphorus,
        this.soilpotassium,
    });

    factory Npk.fromJson(Map<String, dynamic> json) => Npk(
        soiltemperature: json["soiltemperature"],
        soilhumidity: json["soilhumidity"],
        soilconductivity: json["soilconductivity"],
        soilph: json["soilph"],
        soilnitrogen: json["soilnitrogen"],
        soilphosphorus: json["soilphosphorus"],
        soilpotassium: json["soilpotassium"],
    );

    Map<String, dynamic> toJson() => {
        "soiltemperature": soiltemperature,
        "soilhumidity": soilhumidity,
        "soilconductivity": soilconductivity,
        "soilph": soilph,
        "soilnitrogen": soilnitrogen,
        "soilphosphorus": soilphosphorus,
        "soilpotassium": soilpotassium,
    };
}
