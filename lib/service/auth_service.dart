import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/login_response_model.dart';

class AuthService {
  final Dio _dioWithoutInterceptor = Dio(
    BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<LoginResponseModel> login(String username, String password) async {
    try {
      final String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      final response = await _dioWithoutInterceptor.post(
        '/auth/login',
        options: Options(
          headers: {
            'Authorization': basicAuth,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}
