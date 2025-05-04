import 'package:get/get.dart';
import 'package:smart_farm/model/sensor_data_mode.dart';

class SensorController extends GetxController {
  final sensorData = <SensorData>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    _loadSampleData();
  }

  void _loadSampleData() {
    final now = DateTime.now();
    final sampleData = [
      SensorData(
        time: now.subtract(Duration(minutes: 30)),
        humidity: 45.0,
        temperature: 22.5,
        soilHumidity: 60.0,
        soilTemperature: 20.0,
      ),
      SensorData(
        time: now.subtract(Duration(minutes: 20)),
        humidity: 46.0,
        temperature: 23.0,
        soilHumidity: 58.0,
        soilTemperature: 20.5,
      ),
      SensorData(
        time: now.subtract(Duration(minutes: 10)),
        humidity: 47.0,
        temperature: 23.5,
        soilHumidity: 55.0,
        soilTemperature: 21.0,
      ),
      SensorData(
        time: now,
        humidity: 48.0,
        temperature: 24.0,
        soilHumidity: 53.0,
        soilTemperature: 21.5,
      ),
    ];

    sensorData.assignAll(sampleData);
  }

  void addData(SensorData newData) {
    sensorData.add(newData);
  }
}
