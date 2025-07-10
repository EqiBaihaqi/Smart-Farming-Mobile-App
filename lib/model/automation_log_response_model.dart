// To parse this JSON data, do
//
//     final automationLogResponseModel = automationLogResponseModelFromJson(jsonString);

import 'dart:convert';

AutomationLogResponseModel automationLogResponseModelFromJson(String str) => AutomationLogResponseModel.fromJson(json.decode(str));

String automationLogResponseModelToJson(AutomationLogResponseModel data) => json.encode(data.toJson());

class AutomationLogResponseModel {
    List<Datum> data;

    AutomationLogResponseModel({
        required this.data,
    });

    factory AutomationLogResponseModel.fromJson(Map<String, dynamic> json) => AutomationLogResponseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    int batchLocationId;
    double npkTemperatureInput;
    double npkHumidityInput;
    String state;
    int duration;
    DateTime executedAt;

    Datum({
        required this.id,
        required this.batchLocationId,
        required this.npkTemperatureInput,
        required this.npkHumidityInput,
        required this.state,
        required this.duration,
        required this.executedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        batchLocationId: json["batch_location_id"],
        npkTemperatureInput: json["npk_temperature_input"]?.toDouble(),
        npkHumidityInput: json["npk_humidity_input"]?.toDouble(),
        state: json["state"],
        duration: json["duration"],
        executedAt: DateTime.parse(json["executed_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "batch_location_id": batchLocationId,
        "npk_temperature_input": npkTemperatureInput,
        "npk_humidity_input": npkHumidityInput,
        "state": state,
        "duration": duration,
        "executed_at": executedAt.toIso8601String(),
    };
}
