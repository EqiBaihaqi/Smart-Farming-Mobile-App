import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/automation_log_response_model.dart';
import 'package:smart_farm/model/automation_status_response_model.dart';


class AutomationService {
  final Dio dio;
  AutomationService()
    : dio = Dio(
        BaseOptions(
          baseUrl: Constant.baseUrl, // Pastikan Constant.baseUrl sudah benar
          // baseUrl: 'http://10.0.2.2:3333',
          connectTimeout: Duration(seconds: 2),
          receiveTimeout: Duration(seconds: 2),
        ),
      ) {
    // Tambahkan interceptor langsung di constructor
  
  
  }

  Future<AutomationLogResponseModel> getAutomationLog(
    String token,
    DateTime date,
  ) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final response = await dio.get(
        '/api/automation/irrigation/logs',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {'startDate': formattedDate, 'endDate': formattedDate},
      );
      return AutomationLogResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return AutomationLogResponseModel(logs: []);
      }
       throw Exception(
      "Error ${e.response?.statusCode}: Gagal mengambil data log automasi.",
    );
    }
  }

  Future<AutomationStatusResponseModel> getAutomationStatus(
    String token,
  ) async {
    try {
      final response = await dio.get(
        '/api/automation/irrigation/status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AutomationStatusResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  // di dalam automation_service.dart
  // Future<AutomationStatusResponseModel> updateAutomationStatus({
  //   required String token,
  //   required bool isActive,
  // }) async {
  //   try {
  //     final response = await dio.post(
  //       '/api/automation/status',
  //       data: {'is_active': isActive},
  //       options: Options(headers: {'Authorization': 'Bearer $token'}),
  //     );

  //     // --- TAMBAHKAN BARIS INI UNTUK DEBUGGING ---
  //     print('[SERVER RESPONSE DATA]: ${response.data}');

  //     // Parsing akan terjadi di sini, ini adalah kemungkinan sumber error
  //     return AutomationStatusResponseModel.fromJson(response.data);
  //   } on DioException catch (e) {
  //     // Menangkap error koneksi/http
  //     print(e);
  //     throw Exception(
  //       "Error ${e.response?.statusCode}: Gagal memperbarui status.",
  //     );
  //   } catch (e) {
  //     // Menangkap error lainnya, seperti parsing JSON
  //     print('[PARSING ERROR]: $e');
  //     throw Exception('Gagal memproses data dari server.');
  //   }
  // }
}
