// lib/controller/chart_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/model/chart_data_sensor_response_model.dart';
import 'package:smart_farm/service/sensor_data_service.dart';
import 'package:smart_farm/widget/snackbar_widget.dart';

class ChartController extends GetxController {
  final SensorDataService _apiService = SensorDataService();

  var isLoading = true.obs;
  var chartData = <ChartDataSensorResponseModel>[].obs;

  var selectedSensor = 'npk2'.obs;
  var selectedMetric = 'soilHumidity'.obs;
  var selectedDate = DateTime.now().obs;
  var displayDate = ''.obs;

  final List<String> sensorOptions = ['dht', 'npk1', 'npk2'];

  final Map<String, List<String>> metricOptions = {
    'dht': ['viciTemperature', 'viciHumidity', 'viciLuminosity'],
    'npk1': [
      'soilTemperature',
      'soilHumidity',
      'soilPh',
      'soilNitrogen',
      'soilPotassium',
      'soilPhosphorus',
      'soilConductivity',
    ],
    'npk2': [
      'soilTemperature',
      'soilHumidity',
      'soilPh',
      'soilNitrogen',
      'soilPotassium',
      'soilPhosphorus',
      'soilConductivity',
    ],
  };

  // --- PENYEMPURNAAN: Tambahkan Map untuk Label yang User-Friendly ---
  // Ini membuat UI lebih mudah dibaca daripada menampilkan kunci mentah seperti 'viciTemperature'
  final Map<String, String> metricLabels = {
    'viciTemperature': 'Temperature',
    'viciHumidity': 'Humidity',
    'viciLuminosity': 'Luminosity',
    'soilTemperature': 'Temperature',
    'soilHumidity': 'Humidity',
    'soilPh': 'pH',
    'soilNitrogen': 'Nitrogen (N)',
    'soilPotassium': 'Potassium (K)',
    'soilPhosphorus': 'Phosphorus (P)',
    'soilConductivity': 'Conductivity',
  };

  @override
  void onInit() {
    super.onInit();
    updateDisplayDate();
    fetchData();
  }

  void updateDisplayDate() {
    final now = DateTime.now();
    if (selectedDate.value.year == now.year &&
        selectedDate.value.month == now.month &&
        selectedDate.value.day == now.day) {
      displayDate.value = "Hari Ini";
    } else {
      displayDate.value = DateFormat(
        'd MMMM yyyy',
        'id_ID',
      ).format(selectedDate.value);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      updateDisplayDate();
      fetchData();
    }
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      SnackbarWidget.showError(
        title: 'Error',
        message: 'Sesi berakhir, silahkan login kembali.',
      );

      isLoading.value = false;
      return;
    }

    try {
      isLoading.value = true;
      final result = await _apiService.getChartData(
        token: token,
        sensor: selectedSensor.value,
        metric: selectedMetric.value,
        date: selectedDate.value,
      );
      chartData.value = result;
      print(result);
    } catch (e) {
      print(e.toString());
      SnackbarWidget.showError(title: 'Gagal', message: 'Gagal memuat data');
      chartData.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void onSensorChanged(String? newSensor) {
    if (newSensor != null && newSensor != selectedSensor.value) {
      selectedSensor.value = newSensor;
      selectedMetric.value = metricOptions[newSensor]![0];
      fetchData();
    }
  }

  void onMetricChanged(String? newMetric) {
    if (newMetric != null && newMetric != selectedMetric.value) {
      selectedMetric.value = newMetric;
      fetchData();
    }
  }
}
