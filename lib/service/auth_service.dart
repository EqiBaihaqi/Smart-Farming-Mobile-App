import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/jwt_response_model.dart';
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
    final SharedPreferences pref = await SharedPreferences.getInstance();
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
        final data = LoginResponseModel.fromJson(response.data);
        final decodedToken =
            JwtTokenResponse.fromJson(JwtDecoder.decode(data.data!.jwtToken!));
        pref.setString('token', data.data!.token!);
        pref.setString('jwtToken', data.data!.jwtToken!);
        pref.setString('username', decodedToken.user?.username ?? 'unknown');
        pref.setString('email', decodedToken.user?.email ?? 'unknown');
        pref.setString('fullName', decodedToken.user?.fullname ?? 'unknown');
        pref.setBool('isLoggedIn', true);
        return data;
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
