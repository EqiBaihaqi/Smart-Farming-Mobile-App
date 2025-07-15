import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/service/sensor_data_service.dart';
import 'package:smart_farm/widget/snackbar_widget.dart';

class HomeController extends GetxController {
  RxBool isIrrigationOn = false.obs;
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
    username.value = prefs.getString('username') ?? 'Anonnymous';
    email.value = prefs.getString('email') ?? '-';
    fullname.value = prefs.getString('fullname') ?? '-';
  }

  var isLoadingSensor = false.obs;
  // DHT Sensor
  var dhtTemp = 0.obs;
  var dhtHumi = 0.obs;
  var dhtLumi = 0.obs;
  // NPK1 Sensor
  var npk1Temp = 0.obs;
  var npk1Humi = 0.obs;
  var npk1Conduct = 0.obs;
  var npk1Ph = 0.obs;
  var npk1Nitro = 0.obs;
  var npk1Phos = 0.obs;
  var npk1Potas = 0.obs;
  //NPK2 Sensor
  var npk2Temp = 0.obs;
  var npk2Humi = 0.obs;
  var npk2Conduct = 0.obs;
  var npk2Ph = 0.obs;
  var npk2Nitro = 0.obs;
  var npk2Phos = 0.obs;
  var npk2Potas = 0.obs;
  Future<void> getLatestSensorData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      isLoadingSensor(true);
      final response = await sensorDataService.getLatestDataSensor(token ?? '');
      //Insert dht data
      dhtTemp.value = response.data.dht?.temperature ?? 0;
      dhtHumi.value = response.data.dht?.humidity ?? 0;
      dhtLumi.value = response.data.dht?.luminosity ?? 0;
      //Insert npk1 data
      npk1Temp.value = response.data.npk1?.temperature ?? 0;
      npk1Humi.value = response.data.npk1?.humidity ?? 0;
      npk1Conduct.value = response.data.npk1?.conductivity ?? 0;
      npk1Ph.value = response.data.npk1?.ph ?? 0;
      npk1Nitro.value = response.data.npk1?.nitrogen ?? 0;
      npk1Phos.value = response.data.npk1?.phosphorus ?? 0;
      npk1Potas.value = response.data.npk1?.potassium ?? 0;
      //Insert npk2 data
      npk2Temp.value = response.data.npk2?.temperature ?? 0;
      npk2Humi.value = response.data.npk2?.humidity ?? 0;
      npk2Conduct.value = response.data.npk2?.conductivity ?? 0;
      npk2Ph.value = response.data.npk2?.ph ?? 0;
      npk2Nitro.value = response.data.npk2?.nitrogen ?? 0;
      npk2Phos.value = response.data.npk2?.phosphorus ?? 0;
      npk2Potas.value = response.data.npk2?.potassium ?? 0;
    } catch (e) {
      SnackbarWidget.showError(
        title: 'Error',
        message: 'Terjadi kesalahan saat mengambil data real-time',
      );
    } finally {
      isLoadingSensor(false);
    }
  }
}
