import 'package:dio/dio.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/latest_sensor_data_response_model.dart';
import 'package:smart_farm/model/npk_data_response_model.dart';

class SensorDataService {
  final Dio _dioWithoutInterceptor = Dio(
    BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<LatestSensorDataResponseModel> getLatestDataSensor(
    String token,
  ) async {
    try {
      final response = await _dioWithoutInterceptor.get(
        '/api/sensor/getLatest',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return LatestSensorDataResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }

  Future<List<NpkDataModel>> fetchGraphiNpkData({
    required String token,
    required String startDate,
    required String endDate,
    required String metric,
  }) async {
    try {
      final response = await _dioWithoutInterceptor.get(
        '/api/sensor/getData',
        queryParameters: {
          'sensor': metric,
          'range[start]': startDate,
          'range[end]': endDate,
          'range[time_range]': 'HOURLY',
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('API Response: ${response.data}'); // Debug log

      final responseData = response.data['data']?[metric] as List?;
      if (responseData == null) {
        throw Exception('No data available');
      }

      return responseData.map((json) => NpkDataModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Invalid request. Please check date parameters');
      }
      rethrow;
    }
  }
}
