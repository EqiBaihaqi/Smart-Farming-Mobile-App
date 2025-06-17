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
  var dhtTemp = Rxn<double>();
  var dhtHumi = Rxn<double>();
  var dhtLumi = Rxn<double>();
  // NPK1 Sensor
  var npk1Temp = Rxn<double>();
  var npk1Humi = Rxn<double>();
  var npk1Conduct = Rxn<double>();
  var npk1Ph = Rxn<double>();
  var npk1Nitro = Rxn<double>();
  var npk1Phos = Rxn<double>();
  var npk1Potas = Rxn<double>();
  //NPK2 Sensor
  var npk2Temp = Rxn<double>();
  var npk2Humi = Rxn<double>();
  var npk2Conduct = Rxn<double>();
  var npk2Ph = Rxn<double>();
  var npk2Nitro = Rxn<double>();
  var npk2Phos = Rxn<double>();
  var npk2Potas = Rxn<double>();
  Future<void> getLatestSensorData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      isLoadingSensor(true);
      final response = await sensorDataService.getLatestDataSensor(token ?? '');
      //Insert dht data
      dhtTemp.value = response.data.dht.temperature.toDouble();
      dhtHumi.value = response.data.dht.humidity.toDouble();
      dhtLumi.value = response.data.dht.luminosity.toDouble();
      //Insert npk1 data
      npk1Temp.value = response.data.npk1.temperature.toDouble();
      npk1Humi.value = response.data.npk1.humidity.toDouble();
      npk1Conduct.value = response.data.npk1.conductivity.toDouble();
      npk1Ph.value = response.data.npk1.ph.toDouble();
      npk1Nitro.value = response.data.npk1.nitrogen.toDouble();
      npk1Phos.value = response.data.npk1.phosphorus.toDouble();
      npk1Potas.value = response.data.npk1.potassium.toDouble();
      //Insert npk2 data
      npk2Temp.value = response.data.npk2.temperature.toDouble();
      npk2Humi.value = response.data.npk2.humidity.toDouble();
      npk2Conduct.value = response.data.npk2.conductivity.toDouble();
      npk2Ph.value = response.data.npk2.ph.toDouble();
      npk2Nitro.value = response.data.npk2.nitrogen.toDouble();
      npk2Phos.value = response.data.npk2.phosphorus.toDouble();
      npk2Potas.value = response.data.npk2.potassium.toDouble();

      print('inih 1 nih $npk2Humi');
    } catch (e) {
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
