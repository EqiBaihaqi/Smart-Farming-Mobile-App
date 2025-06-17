import 'package:dio/dio.dart';
import 'package:smart_farm/model/automation_log_response_model.dart';
import 'package:smart_farm/model/automation_status_response_model.dart';

class AutomationService {
  final Dio _dioWithoutInterceptor = Dio(
    BaseOptions(
      // baseUrl: Constant.baseUrl,
      baseUrl: 'http://10.0.2.2:3333',
      // connectTimeout: Duration(seconds: 10),
      // receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<AutomationLogResponseModel> getAutomationLog(String token) async {
    try {
      final response = await _dioWithoutInterceptor.get(
        '/api/automation/logs',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AutomationLogResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      print(e);
      throw Exception("Error ${e.response?.statusCode}: Gagal mengambil data.");
    }
  }

  Future<AutomationStatusResponseModel> getAutomationStatus(
    String token,
  ) async {
    try {
      final response = await _dioWithoutInterceptor.get(
        '/api/automation/status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AutomationStatusResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      print(e);
      throw e.toString();
    }
  }

  // di dalam automation_service.dart
  Future<AutomationStatusResponseModel> updateAutomationStatus({
    required String token,
    required bool isActive,
  }) async {
    try {
      final response = await _dioWithoutInterceptor.post(
        '/api/automation/status',
        data: {'is_active': isActive},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // --- TAMBAHKAN BARIS INI UNTUK DEBUGGING ---
      print('[SERVER RESPONSE DATA]: ${response.data}');

      // Parsing akan terjadi di sini, ini adalah kemungkinan sumber error
      return AutomationStatusResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      // Menangkap error koneksi/http
      print(e);
      throw Exception(
        "Error ${e.response?.statusCode}: Gagal memperbarui status.",
      );
    } catch (e) {
      // Menangkap error lainnya, seperti parsing JSON
      print('[PARSING ERROR]: $e');
      throw Exception('Gagal memproses data dari server.');
    }
  }
}
