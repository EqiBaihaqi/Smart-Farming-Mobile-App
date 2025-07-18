import 'package:dio/dio.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/actuator_response_model.dart';

class ActuatorService {
  Dio dio = Dio();

  ActuatorService()
    : dio = Dio(
        BaseOptions(
          baseUrl: Constant.baseUrl, // Pastikan Constant.baseUrl sudah benar
          // baseUrl: 'http://10.0.2.2:3333',
          connectTimeout: Duration(seconds: 2),
          receiveTimeout: Duration(seconds: 2),
        ),
      );

  // --- Method untuk mengambil status semua actuator ---
  Future<List<Actuator>> fetchActuatorStatus(String token) async {
    try {
      // Lakukan GET request. Dio akan melempar DioException jika status code bukan 2xx.
      final response = await dio.get(
        '/api/actuators/status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Dio secara otomatis men-decode JSON. Akses list dari response.data
      List<dynamic> dataList = response.data['data'];

      // Ubah setiap item di list menjadi objek Actuator
      return dataList.map((item) => Actuator.fromJson(item)).toList();
    } on DioException catch (e) {
      // Tangani error spesifik dari Dio dan lemparkan kembali sebagai Exception standar
      // agar bisa ditangkap oleh controller.
      throw Exception('Gagal mengambil data dari API : $e');
    }
  }

  // Method untuk mengubah status actuator pump
  Future<void> executePump(String token, String statusString) async {
    try {
      await dio.post(
        '/api/actuators/pump/control',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: FormData.fromMap({'action': statusString}),
      );
    } on DioException catch (e) {
      throw Exception('Gagal mengeksekusi actuator pump : $e');
    }
  }

  // Method untuk mengubah status actuator water valve
  Future<void> executeWaterValve(String token, String statusString) async {
    try {
      await dio.post(
        '/api/actuators/water-valve/control',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: FormData.fromMap({'action': statusString}),
      );
    } on DioException catch (e) {
      throw Exception('Gagal mengeksekusi actuator pump: $e');
    }
  }

  // Method untuk mengubah status actuator nutrient valve
  Future<void> executeNutrientValve(String token, String statusString) async {
    try {
      await dio.post(
        '/api/actuators/nutrient-valve/control',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: FormData.fromMap({'action': statusString}),
      );
    } on DioException catch (e) {
      throw Exception('Gagal mengeksekusi actuator pump : $e');
    }
  }
}
