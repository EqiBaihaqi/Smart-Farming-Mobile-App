import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/service/irrigation_service.dart';
import 'package:smart_farm/service/sensor_data_service.dart';
import 'package:smart_farm/widget/snackbar_widget.dart';

class HomeController extends GetxController {
  RxBool isIrrigationOn = false.obs;
  IrrigationService irrigationService = IrrigationService();
  SensorDataService sensorDataService = SensorDataService();

  var username = ''.obs;
  var email = ''.obs;
  var fullname = ''.obs;

  @override
  void onInit() {
    loadUserInfo();
    getLatestSensorData();
    super.onInit();
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
    email.value = prefs.getString('email') ?? '';
    fullname.value = prefs.getString('fullname') ?? '';
  }

  var isLoadingSensor = false.obs;
  // DHT Sensor
  var dhtTemp = Rxn<int>();
  var dhtHumi = Rxn<int>();
  var dhtLumi = Rxn<int>();
  // NPK1 Sensor
  var npk1Temp = Rxn<int>();
  var npk1Humi = Rxn<int>();
  var npk1Conduct = Rxn<int>();
  var npk1Ph = Rxn<int>();
  var npk1Nitro = Rxn<int>();
  var npk1Phos = Rxn<int>();
  var npk1Potas = Rxn<int>();
  //NPK2 Sensor
  var npk2Temp = Rxn<int>();
  var npk2Humi = Rxn<int>();
  var npk2Conduct = Rxn<int>();
  var npk2Ph = Rxn<int>();
  var npk2Nitro = Rxn<int>();
  var npk2Phos = Rxn<int>();
  var npk2Potas = Rxn<int>();
  Future<void> getLatestSensorData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      isLoadingSensor(true);
      final response = await sensorDataService.getLatestDataSensor(token ?? '');
      //Insert dht data
      dhtTemp.value = response.data.dht.temperature ?? 0;
      dhtHumi.value = response.data.dht.humidity ?? 0;
      dhtLumi.value = response.data.dht.luminosity ?? 0;
      //Insert npk1 data
      npk1Temp.value = response.data.npk1.temperature ?? 0;
      npk1Humi.value = response.data.npk1.humidity ?? 0;
      npk1Conduct.value = response.data.npk1.conductivity ?? 0;
      npk1Ph.value = response.data.npk1.ph ?? 0;
      npk1Nitro.value = response.data.npk1.nitrogen ?? 0;
      npk1Phos.value = response.data.npk1.phosphorus ?? 0;
      npk1Potas.value = response.data.npk1.potassium ?? 0;
      //Insert npk2 data
      npk2Temp.value = response.data.npk2.temperature ?? 0;
      npk2Humi.value = response.data.npk2.humidity ?? 0;
      npk2Conduct.value = response.data.npk2.conductivity ?? 0;
      npk2Ph.value = response.data.npk2.ph ?? 0;
      npk2Nitro.value = response.data.npk2.nitrogen ?? 0;
      npk2Phos.value = response.data.npk2.phosphorus ?? 0;
      npk2Potas.value = response.data.npk2.potassium ?? 0;

      print('inih isinya nih $dhtTemp');
    } catch (e) {
      SnackbarWidget.showError(
        title: 'Error',
        message: 'Terjadi kesalahan saat mengambil data real-time',
      );
      print(e.toString());
    } finally {
      isLoadingSensor(false);
    }
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
