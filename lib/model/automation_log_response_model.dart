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
    DateTime executedAt;
    int dhtHumidityInput;
    int dhtTemperatureInput;
    int npkTemperatureInput;
    int npkHumidityInput;
    String decision;
    DateTime createdAt;

    Datum({
        required this.id,
        required this.executedAt,
        required this.dhtHumidityInput,
        required this.dhtTemperatureInput,
        required this.npkTemperatureInput,
        required this.npkHumidityInput,
        required this.decision,
        required this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        executedAt: DateTime.parse(json["executed_at"]),
        dhtHumidityInput: json["dht_humidity_input"],
        dhtTemperatureInput: json["dht_temperature_input"],
        npkTemperatureInput: json["npk_temperature_input"],
        npkHumidityInput: json["npk_humidity_input"],
        decision: json["decision"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "executed_at": executedAt.toIso8601String(),
        "dht_humidity_input": dhtHumidityInput,
        "dht_temperature_input": dhtTemperatureInput,
        "npk_temperature_input": npkTemperatureInput,
        "npk_humidity_input": npkHumidityInput,
        "decision": decision,
        "created_at": createdAt.toIso8601String(),
    };
}
