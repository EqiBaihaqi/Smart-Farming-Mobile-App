// Di dalam file model ChartDataSensorResponseModel

class ChartDataSensorResponseModel {
  final DateTime timestamp;
  final double value;

  ChartDataSensorResponseModel({required this.timestamp, required this.value});

  factory ChartDataSensorResponseModel.fromJson(Map<String, dynamic> json) {
    // Parsing value dibuat lebih aman untuk menangani null atau tipe data lain
    final double parsedValue = (json['avg_value'] as num?)?.toDouble() ?? 0.0;

    return ChartDataSensorResponseModel(
      // Parsing timestamp sekarang akan berhasil karena service sudah menyediakan format yang benar
      timestamp: DateTime.parse(json["time_bucket"]),
      value: parsedValue,
    );
  }
}
