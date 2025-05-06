import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/service/irrigation_service.dart';
import 'package:smart_farm/widget/snackbar_widget.dart';

class HomeController extends GetxController {
  RxBool isIrrigationOn = false.obs;
  IrrigationService irrigationService = IrrigationService();

  var username = ''.obs;
  var email = ''.obs;
  var fullname = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
    email.value = prefs.getString('email') ?? '';
    fullname.value = prefs.getString('fullname') ?? '';
  }

  Future<void> turnOnIrrigation() async {
    try {
      final success = await irrigationService.turnOnIrrigation();

      if (success) {
        isIrrigationOn(true);
        SnackbarWidget.showSuccess(
          title: 'Berhasil',
          message: 'Irigasi berhasil dinyalakan',
        );
      } else {
        SnackbarWidget.showError(
          title: 'Gagal',
          message: 'Irigasi gagal dinyalakan',
        );
        isIrrigationOn(false);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> turnOffIrrigation() async {
    try {
      final isIrrigationOff = await irrigationService.turnOffIrrigation();
      if (isIrrigationOff) {
        isIrrigationOn(false);
        SnackbarWidget.showSuccess(
          title: 'Berhasil',
          message: 'Irigasi berhasil dimatikan',
        );
      } else {
        SnackbarWidget.showError(
          title: 'Gagal',
          message: 'Irigasi gagal dimatikan',
        );
        isIrrigationOn(true);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
