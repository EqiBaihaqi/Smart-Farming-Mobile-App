import 'package:get/get.dart';
import 'package:smart_farm/service/irrigation_service.dart';

class HomeController extends GetxController {
  RxBool isIrrigationOn = false.obs;
  IrrigationService irrigationService = IrrigationService();
  Future<void> turnOnIrrigation() async {
    try {
      final success = await irrigationService.turnOnIrrigation();

      if (success) {
        isIrrigationOn(true);
        Get.snackbar('Berhasil', 'Irigasi berhasil dinyalakan');
      } else {
        Get.snackbar('Gagal', 'Irigasi gagal dinyalakan');
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
        Get.snackbar('Berhasil', 'Irigasi berhasil dimatikan');
      } else {
        Get.snackbar('Gagal', 'Irigasi gagal dimatikan');
        isIrrigationOn(true);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
