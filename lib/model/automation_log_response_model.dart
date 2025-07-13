// To parse this JSON data, do
//
//     final automationLogResponseModel = automationLogResponseModelFromJson(jsonString);

import 'dart:convert';

AutomationLogResponseModel automationLogResponseModelFromJson(String str) =>
    AutomationLogResponseModel.fromJson(json.decode(str));

String automationLogResponseModelToJson(AutomationLogResponseModel data) =>
    json.encode(data.toJson());

class AutomationLogResponseModel {
  List<Datum> logs;

  AutomationLogResponseModel({required this.logs});

  factory AutomationLogResponseModel.fromJson(Map<String, dynamic> json) =>
      AutomationLogResponseModel(
        logs: List<Datum>.from(json["logs"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? bathchLocationId;
  double? npkTemperatureInput;
  double? npkHumidityInput;
  String? state;
  int? duration;
  DateTime? executedAt;

  Datum({
    required this.id,
    required this.bathchLocationId,
    required this.npkTemperatureInput,
    required this.npkHumidityInput,
    required this.state,
    required this.duration,
    required this.executedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    bathchLocationId: json["bathchLocationId"],
    npkTemperatureInput: json["npkTemperatureInput"]?.toDouble(),
    npkHumidityInput: json["npkHumidityInput"]?.toDouble(),
    state: json["state"],
    duration: json["duration"],
    executedAt: DateTime.parse(json["executed_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bathchLocationId": bathchLocationId,
    "npkTemperatureInput": npkTemperatureInput,
    "npkHumidityInput": npkHumidityInput,
    "state": state,
    "duration": duration,
    "executed_at": executedAt?.toIso8601String(),
  };
}
