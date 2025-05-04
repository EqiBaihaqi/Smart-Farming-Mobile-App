import 'package:get/get.dart';
import 'package:smart_farm/service/irrigation_service.dart';
import 'package:smart_farm/widget/snackbar_widget.dart';

class HomeController extends GetxController {
  RxBool isIrrigationOn = false.obs;
  IrrigationService irrigationService = IrrigationService();
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
