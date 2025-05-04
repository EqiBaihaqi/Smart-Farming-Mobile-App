import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_farm/home.dart';
import 'package:smart_farm/page/login_page/login_page.dart';

class SplashController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void onInit() {
    checkToken();
    super.onInit();
  }

  void checkToken() {
    Future.delayed(const Duration(seconds: 2), () {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        Get.offAll(() => Home());
      } else {
        Get.offAll(() => LoginPage());
      }
    });
  }
}
