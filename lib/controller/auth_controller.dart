import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:smart_farm/home.dart';
import 'package:smart_farm/model/login_response_model.dart';
import 'package:smart_farm/page/login_page/login_page.dart';
import 'package:smart_farm/service/auth_service.dart';
import 'package:smart_farm/service/shared_preferences.dart';
import 'package:smart_farm/widget/snackbar_widget.dart';
// Add this import

class AuthController extends GetxController {
  final AuthService _loginService = AuthService();
  final StorageService _storageService = StorageService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> login(String username, String password) async {
    try {
      isLoading(true);
      errorMessage('');

      // Now returns a LoginResponse
      final LoginResponseModel response = await _loginService.login(
        username,
        password,
      );

      // Save tokens using the model
      await _storageService.saveTokens(
        response.data!.token!,
        response.data!.jwtToken!,
      );

      Get.offAll(() => Home());
      SnackbarWidget.showSuccess(
        title: 'Login berhasil',
        message: 'Selamat datang kembali ^^',
      );
    } on DioException catch (e) {
      // Handle Dio-specific errors
      final statusCode = e.response?.statusCode;

      if (statusCode == 401) {
        errorMessage('Invalid email or password');
      } else if (statusCode == 404) {
        errorMessage('User not found');
      } else if (statusCode != null) {
        errorMessage('Server error ($statusCode)');
      } else {
        errorMessage('Network error: ${e.message}');
      }
    } catch (e) {
      errorMessage('Terjadi kesalahan, coba lagi nanti');
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      await _storageService.clearTokens();
      Get.offAll(() => LoginPage());
    } catch (e) {
      SnackbarWidget.showError(
        title: 'Error',
        message: 'Failed to logout: ${e.toString()}',
      );
    }
  }
}
