// REKOMENDASI: Hapus fungsi helper ini karena tidak sesuai dan tidak digunakan.
// Service Anda sudah melakukan parsing manual yang lebih baik.

class ChartDataSensorResponseModel {
  final DateTime timestamp;
  final double value;

  ChartDataSensorResponseModel({required this.timestamp, required this.value});

  factory ChartDataSensorResponseModel.fromJson(Map<String, dynamic> json) {
    return ChartDataSensorResponseModel(
      timestamp: DateTime.parse(json["time_bucket"]),

      // --- PERBAIKAN DI SINI ---
      // Ubah dari casting 'as num' menjadi parsing 'double.parse()'
      // Tambahkan .toString() untuk keamanan jika suatu saat API mengirim angka, bukan string
      value: double.parse(json["avg_value"].toString()),
    );
  }
}
