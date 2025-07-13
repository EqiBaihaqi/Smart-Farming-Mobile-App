// To parse this JSON data, do
//
//    final automationStatusResponseModel = automationStatusResponseModelFromJson(jsonString);

import 'dart:convert';

AutomationStatusResponseModel automationStatusResponseModelFromJson(
  String str,
) => AutomationStatusResponseModel.fromJson(json.decode(str));

String automationStatusResponseModelToJson(
  AutomationStatusResponseModel data,
) => json.encode(data.toJson());

class AutomationStatusResponseModel {
  bool isActive;
  // DIUBAH: Jadikan nullable (opsional) dengan menambahkan '?'
  DateTime? updatedAt;

  AutomationStatusResponseModel({
    required this.isActive,
    // DIUBAH: Tidak lagi 'required' karena bisa jadi null
    this.updatedAt,
  });

  factory AutomationStatusResponseModel.fromJson(Map<String, dynamic> json) {
    // Respons GET dan POST mungkin berbeda. Kita tangani keduanya.
    // Cek apakah ada object 'data' di dalam JSON
    final data = json.containsKey('data') ? json['data'] : json;

    return AutomationStatusResponseModel(
      // DIUBAH: Ambil 'isActive' dari dalam object 'data'
      isActive: data["isActive"],
      // DIUBAH: Cek dulu apakah 'updated_at' ada sebelum di-parse
      updatedAt:
          data["updated_at"] == null
              ? null
              : DateTime.parse(data["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "isActive": isActive,
    // DIUBAH: Cek null sebelum diubah ke string
    "updated_at": updatedAt?.toIso8601String(),
  };
}
