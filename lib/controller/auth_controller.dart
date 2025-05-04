import 'package:get/get.dart';
import 'package:smart_farm/home.dart';
import 'package:smart_farm/page/login_page/login_page.dart';
import 'package:smart_farm/service/auth_service.dart';
import 'package:smart_farm/widget/loading_widget.dart';

class AuthController extends GetxController {
  void loginWithGoogle() async {
    try {
      LoadingWidget.showLoadingDialog();
      final user = await AuthService.signInWithGoogle();
      if (user != null) {
        Get.snackbar('Berhasil', 'Login berhasil dilakukan');
        Get.offAll(() => Home());
      } else {
        Get.snackbar('Batal', 'Login dibatalkan');
      }
    } catch (e) {
      Get.snackbar('Login Gagal', e.toString());
    } finally {
      LoadingWidget.hideLoadingDialog();
    }
  }

  void logout() async {
    try {
      LoadingWidget.showLoadingDialog();
      AuthService.signout();
      Get.offAll(() => LoginPage());
      Get.snackbar('Berhasil', 'Log out berhasil dilakukan');
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'e.toString');
    } finally {
      LoadingWidget.hideLoadingDialog();
    }
  }
}
