// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smart_farm/model/dht_data_response_model.dart';
// import 'package:smart_farm/model/npk_data_response_model.dart';
// import 'package:smart_farm/service/sensor_data_service.dart';

// class SensorController extends GetxController {
//   var npk1List = <NpkDataModel>[].obs;
//   var npk2List = <NpkDataModel>[].obs;
//   var dhtList = <Dht>[].obs;
//   var sensordataService = SensorDataService();
//   var isLoading = false.obs;

//   @override
//   void onInit() async {
//     loadNpk1GrapchicData();
//     loadNpk2GrapchicData();
//     loadDhtGraphicData();
//     super.onInit();
//   }

//   Future<void> loadNpk1GrapchicData() async {
//     isLoading.value = true;
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     npk1List.clear();
//     try {
//       final DateTime now = DateTime.now();
//       final String startDate = _formatDate(now);
//       final String endDate = _formatDate(now);
//       final data = await sensordataService.fetchGraphiNpkData(
//         metric: 'npk1',
//         token: token ?? '',
//         startDate: startDate,
//         endDate: endDate,
//       );
//       npk1List.value = data;
//     } catch (e) {
//       print('Error loading NPK data: $e');
//       npk1List.clear();
//     } finally {
//       isLoading.value = false;
//       print('Current NPK data count: ${npk1List.length}');
//     }
//   }

//   Future<void> loadNpk2GrapchicData() async {
//     isLoading.value = true;
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     npk2List.clear();
//     try {
//       final DateTime now = DateTime.now();
//       final String startDate = _formatDate(now);
//       final String endDate = _formatDate(now);
//       final data = await sensordataService.fetchGraphiNpkData(
//         metric: 'npk2',
//         token: token ?? '',
//         startDate: startDate,
//         endDate: endDate,
//       );
//       npk2List.value = data;
//     } catch (e) {
//       print('Error loading NPK data: $e');
//       npk2List.clear();
//     } finally {
//       isLoading.value = false;
//       print('Current NPK2 data count: ${npk2List.length}');
//     }
//   }

//   Future<void> loadDhtGraphicData() async {
//     isLoading(true);
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     final now = _formatDate(DateTime.now());
//     dhtList.clear();
//     try {
//       final response = await sensordataService.fetchDhtGraphicData(
//         token: token ?? '',
//         startDate: now,
//         endDate: now,
//         metric: 'dht',
//       );
//       dhtList.value = response.data.dht;
//     } catch (e) {
//       print('Error loading DHT data: $e');
//       dhtList.clear();
//     } finally {
//       isLoading.value = false;
//       print('Current DHT data count: ${dhtList.length}');
//     }
//   }

//   String _formatDate(DateTime date) {
//     return DateFormat('yyyy-MM-dd').format(date);
//   }
// }
