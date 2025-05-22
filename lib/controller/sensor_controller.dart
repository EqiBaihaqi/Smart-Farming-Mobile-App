import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/model/npk_data_response_model.dart';
import 'package:smart_farm/service/sensor_data_service.dart';

class SensorController extends GetxController {
  var npk1List = <NpkDataModel>[].obs;
  var npk2List = <NpkDataModel>[].obs;
  var sensordataService = SensorDataService();
  var isLoading = false.obs;

  @override
  void onInit() async {
    loadNpk1GrapchicData();
    super.onInit();
  }

  Future<void> loadNpk1GrapchicData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final DateTime now = DateTime.now();
      final String startDate = _formatDate(now);
      final String endDate = _formatDate(now);
      final data = await sensordataService.fetchGraphicData(
        metric: 'npk1',
        token: token ?? '',
        startDate: startDate,
        endDate: endDate,
      );
      npk1List.value = data;
    } catch (e) {
      print('Error loading NPK data: $e');
      npk1List.clear();
    } finally {
      isLoading.value = false;
      print('Current NPK data count: ${npk1List.length}');
    }
  }

  Future<void> loadNpk2GrapchicData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final DateTime now = DateTime.now();
      final String startDate = _formatDate(now);
      final String endDate = _formatDate(now);
      final data = await sensordataService.fetchGraphiNpkData(
        metric: 'npk2',
        token: token ?? '',
        startDate: startDate,
        endDate: endDate,
      );
      npk2List.value = data;
    } catch (e) {
      print('Error loading NPK data: $e');
      npk2List.clear();
    } finally {
      isLoading.value = false;
      print('Current NPK data count: ${npk2List.length}');
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
