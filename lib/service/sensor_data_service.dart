import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/model/chart_data_sensor_response_model.dart';
import 'package:smart_farm/model/sensor_reading_response_model.dart';

class SensorDataService {
  final Dio _dioWithoutInterceptor = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3333',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<SensorReadingResponseModel> getLatestDataSensor(String token) async {
    try {
      final response = await _dioWithoutInterceptor.get(
        '/api/sensor-reading/latest',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return SensorReadingResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // --- FUNGSI getChartData DENGAN PERBAIKAN FINAL ---
  Future<List<ChartDataSensorResponseModel>> getChartData({
    required String sensor,
    required String metric,
    required DateTime date,
    required String token,
  }) async {
    try {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      // PENTING: Menggunakan endpoint yang benar dari Postman
      const String endpoint = '/api/sensor-reading/search';

      final Map<String, dynamic> queryParams = {
        'sensor': sensor,
        'metric': metric,
        'range[time_range]': 'HOURLY',
        'range[start]': formattedDate,
        'range[end]': formattedDate,
      };

      final response = await _dioWithoutInterceptor.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        dynamic responseBody = response.data;
        if (responseBody is String) {
          responseBody = json.decode(responseBody);
        }

        List<dynamic> responseData = responseBody['data'];

        // PENTING: Logika baru untuk menangani nama field dinamis
        return responseData.map((pointJson) {
          // Buat map baru yang terstandarisasi agar cocok dengan model
          final standardizedJson = {
            "time_bucket": pointJson["time_bucket"],
            // Ambil nilai dari field dinamis (misal: 'temperature')
            // dan masukkan ke field 'avg_value' yang diharapkan model
            "avg_value": pointJson[metric],
          };
          // Kirim map yang sudah standar ke model kita
          return ChartDataSensorResponseModel.fromJson(standardizedJson);
        }).toList();
      } else {
        throw Exception(
          'Gagal memuat data grafik dengan status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print("DioException: ${e.response?.statusCode} - ${e.response?.data}");
      throw Exception("Error ${e.response?.statusCode}: Gagal mengambil data.");
    } catch (e, s) {
      print("Error tak terduga: $e\nStacktrace: $s");
      throw Exception(e.toString());
    }
  }
}
