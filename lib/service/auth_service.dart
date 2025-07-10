import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
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
          // baseUrl: Constant.baseUrl, // Pastikan Constant.baseUrl sudah benar
          baseUrl: 'http://10.0.2.2:3333',
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
        ),
      ) {
    // Tambahkan interceptor langsung di constructor
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print, // Wajib selama development untuk debugging
        retries: 3, // Coba ulang maksimal 3 kali
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
        pref.setString('fullName', decodedToken.user?.fullname ?? 'unknown');
        pref.setBool('isLoggedIn', true);
        return data;
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print("Dio Error!");
      print("Type: ${e.type}");
      print("Message: ${e.message}");
      print("Response: ${e.response?.data}");

      throw Exception(
        e.response?.data?['message'] ?? 'Koneksi ke server gagal: ${e.type}',
      );
      // --- AKHIR PERBAIKAN ---
    } catch (e) {
      print("Unexpected Error: $e");
      throw Exception('An unexpected error occurred');
    }
  }
}
