import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/chart_data_sensor_response_model.dart';
import 'package:smart_farm/model/sensor_reading_response_model.dart';

class SensorDataService {
  late final Dio dio;
  SensorDataService()
    : dio = Dio(
        BaseOptions(
          baseUrl: Constant.baseUrl,
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
        ),
      ) {
    // Tambahkan interceptor langsung di constructor
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print,
        retries: 3, // Coba ulang maksimal 3 kali
        retryDelays: const [
          Duration(seconds: 2), // Jeda 2 detik sebelum percobaan pertama
          Duration(seconds: 4), // Jeda 4 detik sebelum percobaan kedua
          Duration(seconds: 8), // Jeda 8 detik sebelum percobaan ketiga,
          Duration(seconds: 10), // Jeda 8 detik sebelum percobaan ketiga
          Duration(seconds: 12), // Jeda 8 detik sebelum percobaan ketiga
        ],
        // Ini memastikan retry juga berjalan pada error timeout dari server
        retryableExtraStatuses: {status408RequestTimeout},
      ),
    );
  }

  Future<SensorReadingResponseModel> getLatestDataSensor(String token) async {
    try {
      final response = await dio.get(
        '/api/sensor-readings/latest',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return SensorReadingResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ChartDataSensorResponseModel>> getChartData({
    required String sensor,
    required String metric,
    required DateTime date,
    required String token,
  }) async {
    try {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      const String endpoint = '/api/sensor-readings/search';

      final Map<String, dynamic> queryParams = {
        'sensor': sensor,
        'metric': metric,
        'range[time_range]': 'HOURLY',
        'range[start]': formattedDate,
        'range[end]': formattedDate,
      };

      final response = await dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        dynamic responseBody = response.data;
        if (responseBody is String) {
          try {
            responseBody = json.decode(responseBody);
          } catch (e) {
            return [];
          }
        }

        // Periksa apakah dataPayload kosong atau tidak
        final dynamic dataPayload = responseBody['data'];

        // Kasus khusus ketika dataPayload adalah Map kosong
        if (dataPayload == null ||
            (dataPayload is Map && dataPayload.isEmpty)) {
          return [];
        }

        List<dynamic> responseData = [];

        // Handle berbagai format respons
        if (dataPayload is List) {
          responseData = dataPayload;
        } else if (dataPayload is Map) {
          // Cari kunci yang sesuai dengan sensor
          if (dataPayload.containsKey(sensor) && dataPayload[sensor] is List) {
            responseData = dataPayload[sensor];
          } else {
            // Fallback: cari kunci pertama yang berisi List
            final key = dataPayload.keys.firstWhere(
              (k) => dataPayload[k] is List,
              orElse: () => '',
            );
            if (key.isNotEmpty) {
              responseData = dataPayload[key];
            } else {
              return [];
            }
          }
        }

        if (responseData.isEmpty) {
          return [];
        }

        // Proses mapping data dengan filter null values
        final result =
            responseData
                .map((item) {
                  try {
                    final metricValue = item[metric];

                    // Skip jika nilai metric null atau tidak valid
                    if (metricValue == null) {
                      return null;
                    }

                    // Pastikan date dan hour ada dan valid
                    final date = item['date']?.toString() ?? '';
                    final hour = item['hour']?.toString() ?? '0';

                    if (date.isEmpty) {
                      return null;
                    }

                    return ChartDataSensorResponseModel.fromJson({
                      "time_bucket": "${date}T${hour.padLeft(2, '0')}:00:00",
                      "avg_value": metricValue,
                    });
                  } catch (e) {
                    return null;
                  }
                })
                .where((item) => item != null)
                .toList();
        return result.cast<ChartDataSensorResponseModel>();
      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {}
      throw Exception(
        e.response?.data?['message'] ?? 'Kesalahan jaringan: ${e.message}',
      );
    } catch (e) {
      throw Exception('Gagal memproses data: $e');
    }
  }
}
