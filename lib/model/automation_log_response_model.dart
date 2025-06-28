// To parse this JSON data, do
//
//     final automationLogResponseModel = automationLogResponseModelFromJson(jsonString);

import 'dart:convert';

AutomationLogResponseModel automationLogResponseModelFromJson(String str) =>
    AutomationLogResponseModel.fromJson(json.decode(str));

String automationLogResponseModelToJson(AutomationLogResponseModel data) =>
    json.encode(data.toJson());

class AutomationLogResponseModel {
  List<Datum> data;

  AutomationLogResponseModel({required this.data});

  factory AutomationLogResponseModel.fromJson(Map<String, dynamic> json) =>
      AutomationLogResponseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  DateTime executedAt;
  double dhtHumidityInput;
  double dhtTemperatureInput;
  double npkTemperatureInput;
  double npkHumidityInput;
  String state;

  Datum({
    required this.id,
    required this.executedAt,
    required this.dhtHumidityInput,
    required this.dhtTemperatureInput,
    required this.npkTemperatureInput,
    required this.npkHumidityInput,
    required this.state,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    executedAt: DateTime.parse(json["executed_at"]),
    dhtHumidityInput: (json["dht_humidity_input"] as num).toDouble(),
    dhtTemperatureInput: (json["dht_temperature_input"] as num).toDouble(),
    npkTemperatureInput: (json["npk_temperature_input"] as num).toDouble(),
    npkHumidityInput: (json["npk_humidity_input"] as num).toDouble(),
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "executed_at": executedAt.toIso8601String(),
    "dht_humidity_input": dhtHumidityInput,
    "dht_temperature_input": dhtTemperatureInput,
    "npk_temperature_input": npkTemperatureInput,
    "npk_humidity_input": npkHumidityInput,
    "state": state,
  };
}
