import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/actuator_response_model.dart';
import 'package:smart_farm/service/auth_interceptor.dart';

class ActuatorService {
  Dio dio = Dio();

  ActuatorService()
    : dio = Dio(
        BaseOptions(
          baseUrl: Constant.baseUrl, // Pastikan Constant.baseUrl sudah benar
          // baseUrl: 'http://10.0.2.2:3333',
          connectTimeout: Duration(seconds: 3),
          receiveTimeout: Duration(seconds: 3),
        ),
      ) {
    // token interceptor
    dio.interceptors.add(AuthInterceptor());
    // Tambahkan interceptor langsung di constructor
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print, // Wajib selama development untuk debugging
        retries: 5, // Coba ulang maksimal 3 kali
        retryDelays: const [
          Duration(seconds: 2), // Jeda 2 detik sebelum percobaan pertama
          Duration(seconds: 4), // Jeda 4 detik sebelum percobaan kedua
          Duration(seconds: 8), // Jeda 8 detik sebelum percobaan ketiga
          Duration(seconds: 10), // Jeda 8 detik sebelum percobaan ketiga
          Duration(seconds: 12), // Jeda 8 detik sebelum percobaan ketiga
        ],
        // Ini memastikan retry juga berjalan pada error timeout dari server
        retryableExtraStatuses: {status408RequestTimeout},
      ),
    );
  }

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
