import 'package:get/get.dart';
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
    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    final StorageService storage = StorageService();
    final String? token =
        await storage.getToken(); // Assuming you have this method

    Get.offAll(() => token != null ? Home() : LoginPage());
  }
}
