import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/constant/constant.dart';
import 'package:smart_farm/model/jwt_response_model.dart';
import 'package:smart_farm/model/login_response_model.dart';

class AuthService {
  late final Dio dio;
  AuthService()
    : dio = Dio(
        BaseOptions(
          baseUrl: Constant.baseUrl, // Pastikan Constant.baseUrl sudah benar
          // baseUrl: 'http://10.0.2.2:3333',
          connectTimeout: Duration(seconds: 2),
          receiveTimeout: Duration(seconds: 2),
        ),
      );

  Future<LoginResponseModel> login(String username, String password) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      final formData = FormData.fromMap({
        'remember_me': true, // Kirim sebagai boolean, dio akan menanganinya
      });
      final response = await dio.post(
        '/auth/login',
        options: Options(headers: {'Authorization': basicAuth}),
        data: formData,
      );

      if (response.statusCode == 200) {
        final data = LoginResponseModel.fromJson(response.data);
        final decodedToken = JwtTokenResponse.fromJson(
          JwtDecoder.decode(data.data!.jwtToken!),
        );
        pref.setString('token', data.data!.token!);
        pref.setString('jwtToken', data.data!.jwtToken!);
        pref.setString('username', decodedToken.user?.username ?? 'unknown');
        pref.setString('email', decodedToken.user?.email ?? 'unknown');
        pref.setString('fullname', decodedToken.user?.fullname ?? 'unknown');
        pref.setBool('isLoggedIn', true);
        return data;
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception("Error ${e.response?.statusCode}: Gagal melakukan login");
    }
  }
}
