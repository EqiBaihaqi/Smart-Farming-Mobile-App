import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:smart_farm/home.dart';
import 'package:smart_farm/page/login_page/login_page.dart';
import 'package:smart_farm/service/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    _checkToken();
    super.onInit();
  }

  Future<void> _checkToken() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash delay
    final StorageService storage = StorageService();
    final String? token =
        await storage.getToken(); // Assuming you have this method
    final String? jwtToken = await storage.getJwtToken();
    if (token != null && !JwtDecoder.isExpired(jwtToken!)) {
      Get.offAll(Home());
    } else {
      Get.offAll(LoginPage());
    }
  }
}
