import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../page/login_page/login_page.dart'; // Sesuaikan path

class AuthInterceptor extends Interceptor {
  // Menambahkan token ke setiap request
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Abaikan request ke endpoint login
    if (options.path.contains('/auth/login')) {
      return handler.next(options);
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  // Menangani error
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Cek jika errornya adalah 401 (Token kadaluwarsa/tidak valid)
    if (err.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      //hapus token
      await prefs.clear();

      // 2. Arahkan ke halaman login menggunakan GetX
      Get.offAll(() => LoginPage()); // Pastikan LoginPage adalah const

      // 3. Hentikan request agar tidak dilanjutkan
      // Kita bisa membuat error baru yang lebih deskriptif untuk UI jika perlu
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: "Sesi Anda telah berakhir. Silakan login kembali.",
        ),
      );
    }

    // Jika error bukan 401, biarkan saja
    return handler.next(err);
  }
}
