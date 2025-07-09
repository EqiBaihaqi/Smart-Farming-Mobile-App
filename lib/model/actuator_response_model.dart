// lib/models/actuator_model.dart

import 'dart:convert';

// Fungsi helper untuk mengubah List JSON menjadi List<Actuator>
List<Actuator> actuatorListFromJson(String str) =>
    List<Actuator>.from(json.decode(str)['data'].map((x) => Actuator.fromJson(x)));

class Actuator {
    final String name;
    final String currentStatus;
    final String? lastChangedAt;
    final String? lastTriggeredBy;

    Actuator({
        required this.name,
        required this.currentStatus,
        this.lastChangedAt,
        this.lastTriggeredBy,
    });

    factory Actuator.fromJson(Map<String, dynamic> json) => Actuator(
        name: json["name"],
        currentStatus: json["currentStatus"],
        lastChangedAt: json["lastChangedAt"],
        lastTriggeredBy: json["lastTriggeredBy"],
    );
}