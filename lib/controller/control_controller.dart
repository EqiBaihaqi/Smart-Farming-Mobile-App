import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/model/actuator_response_model.dart';
import 'package:smart_farm/service/actuator_service.dart'; // Sesuaikan path jika perlu

class ControlController extends GetxController {
  // Instance dari Service dan GetStorage
  final ActuatorService _actuatorService = ActuatorService();

  // State untuk loading halaman awal
  var isLoading = true.obs;
  // State untuk menyimpan pesan error
  var errorMessage = ''.obs;

  // State untuk status ON/OFF setiap aktuator
  var isPumpOn = false.obs;
  var isWaterValveOn = false.obs;
  var isNutrientValveOn = false.obs;

  // State untuk melacak aktuator mana yang sedang dieksekusi (loading individual)
  var executingActuators = <String>{}.obs;

  // --- LIFECYCLE METHOD ---

  @override
  void onInit() {
    super.onInit();
    fetchInitialStatus();
  }

  // Mengambil data awal dari API
  Future<void> fetchInitialStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      isLoading(true);
      List<Actuator> actuators = await _actuatorService.fetchActuatorStatus(
        token ?? '',
      );

      // Update state berdasarkan data dari API
      for (var actuator in actuators) {
        bool status = actuator.currentStatus == "ON";
        if (actuator.name == "Pump") {
          isPumpOn.value = status;
        } else if (actuator.name == "Water Valve") {
          isWaterValveOn.value = status;
        } else if (actuator.name == "Nutrient Valve") {
          isNutrientValveOn.value = status;
        }
      }
    } catch (e) {
      errorMessage('Gagal memuat status: ${e.toString()}');
      Get.snackbar('Error', 'Tidak dapat memuat status aktuator.');
    } finally {
      isLoading(false);
    }
  }

  // --- FUNGSI EKSEKUSI AKTUATOR ---

  // Fungsi generik untuk mengeksekusi aktuator
  Future<void> _executeActuator({
    required String name,
    required bool newValue,
    required RxBool stateVariable,
    required Future<void> Function(String, String) serviceCall,
  }) async {
    // Tambahkan aktuator ke daftar eksekusi untuk menampilkan loading individual
    executingActuators.add(name);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      String statusString = newValue ? "ON" : "OFF";
      await serviceCall(token ?? '', statusString);

      // Jika berhasil, update state UI
      stateVariable.value = newValue;
      Get.snackbar(
        'Sukses',
        'Status $name berhasil diubah.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Tidak dapat mengubah status $name.',
        snackPosition: SnackPosition.BOTTOM,
      );
      // State tidak diubah jika gagal, sehingga UI kembali ke posisi semula secara otomatis
    } finally {
      // Hapus aktuator dari daftar eksekusi
      executingActuators.remove(name);
    }
  }

  // Panggil fungsi eksekusi untuk PUMP
  void togglePump(bool value) {
    _executeActuator(
      name: 'Pump',
      newValue: value,
      stateVariable: isPumpOn,
      serviceCall: _actuatorService.executePump,
    );
  }

  // Panggil fungsi eksekusi untuk WATER VALVE
  void toggleWaterValve(bool value) {
    _executeActuator(
      name: 'Water Valve',
      newValue: value,
      stateVariable: isWaterValveOn,
      serviceCall: _actuatorService.executeWaterValve,
    );
  }

  // Panggil fungsi eksekusi untuk NUTRIENT VALVE
  void toggleNutrientValve(bool value) {
    _executeActuator(
      name: 'Nutrient Valve',
      newValue: value,
      stateVariable: isNutrientValveOn,
      serviceCall: _actuatorService.executeNutrientValve,
    );
  }
}
