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
      dhtTemp.value = response.data?.dht?.vicitemperature;
      dhtHumi.value = response.data?.dht?.vicihumidity;
      dhtLumi.value = response.data?.dht?.viciluminosity;
      //Insert npk1 data
      npk1Temp.value = response.data?.npk1?.soiltemperature;
      npk1Humi.value = response.data?.npk1?.soilhumidity;
      npk1Conduct.value = response.data?.npk1?.soilconductivity;
      npk1Ph.value = response.data?.npk1?.soilph;
      npk1Nitro.value = response.data?.npk1?.soilnitrogen;
      npk1Phos.value = response.data?.npk1?.soilphosphorus;
      npk1Potas.value = response.data?.npk1?.soilpotassium;
      //Insert npk2 data
      npk2Temp.value = response.data?.npk2?.soiltemperature;
      npk2Humi.value = response.data?.npk2?.soilhumidity;
      npk2Conduct.value = response.data?.npk2?.soilconductivity;
      npk2Ph.value = response.data?.npk2?.soilph;
      npk2Nitro.value = response.data?.npk2?.soilnitrogen;
      npk2Phos.value = response.data?.npk2?.soilphosphorus;
      npk2Potas.value = response.data?.npk2?.soilpotassium;
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
