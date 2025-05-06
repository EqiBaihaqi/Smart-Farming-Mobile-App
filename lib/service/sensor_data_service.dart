import 'package:dio/dio.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/latest_sensor_data_response_model.dart';

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
}
