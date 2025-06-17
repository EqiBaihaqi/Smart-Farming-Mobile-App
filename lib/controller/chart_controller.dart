// lib/controller/chart_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/model/chart_data_sensor_response_model.dart';
import 'package:smart_farm/service/sensor_data_service.dart';

class ChartController extends GetxController {
  final SensorDataService _apiService = SensorDataService();

  // --- STATE KEMBALI DISEDERHANAKAN ---
  var isLoading = true.obs;
  // Kembali ke satu list data untuk satu grafik
  var chartData = <ChartDataSensorResponseModel>[].obs;

  // State untuk pilihan di UI
  var selectedSensor = 'dht'.obs;
  var selectedMetric = 'temperature'.obs;
  var selectedDate = DateTime.now().obs;
  var displayDate = ''.obs;

  // --- Opsi untuk Dropdown Disesuaikan ---
  final List<String> sensorOptions = ['dht', 'npk', 'npk2'];

  // Map ini sangat berguna untuk menyediakan opsi metrik yang dinamis
  final Map<String, List<String>> metricOptions = {
    'dht': ['temperature', 'humidity', 'luminosity'],
    'npk': [
      'temperature',
      'humidity',
      'ph',
      'nitrogen',
      'potassium',
      'phosphorus',
      'conductivity',
    ],
    'npk2': [
      'temperature',
      'humidity',
      'ph',
      'nitrogen',
      'potassium',
      'phosphorus',
      'conductivity',
    ],
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

  // --- FUNGSI FETCHDATA KEMBALI SEDERHANA ---
  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      isLoading.value = true;
      final result = await _apiService.getChartData(
        token: token!,
        sensor: selectedSensor.value, // Langsung pakai state
        metric: selectedMetric.value, // Langsung pakai state
        date: selectedDate.value,
      );
      chartData.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      chartData.value = []; // Kosongkan data jika error
    } finally {
      isLoading.value = false;
    }
  }

  // --- FUNGSI HANDLER UNTUK UI ---
  void onSensorChanged(String? newSensor) {
    if (newSensor != null && newSensor != selectedSensor.value) {
      selectedSensor.value = newSensor;
      // PENTING: Reset pilihan metrik ke item pertama dari list yang baru
      // Ini untuk menghindari state yang tidak valid (misal: sensor 'dht' dengan metrik 'ph')
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
