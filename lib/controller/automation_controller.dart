// controllers/automation_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/model/automation_log_response_model.dart';
import 'package:smart_farm/service/automation_service.dart';
import 'package:smart_farm/widget/snackbar_widget.dart';

class AutomationController extends GetxController {
  final AutomationService service = AutomationService();

  // --- STATE UNTUK LOG ---
  var isLoadingLogs = false.obs;
  var automationLogList = <Datum>[].obs;

  // --- STATE UNTUK STATUS OTOMASI ---
  // Gunakan Rxn<bool> agar bisa membedakan kondisi null (belum dimuat)
  var automationStatus = Rxn<bool>();
  // State baru untuk loading status awal
  var isLoadingStatus = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAutomationStatus();
    getAutomationLog();
  }

  /// Mengambil status otomasi terbaru dari server
  Future<void> getAutomationStatus() async {
    // Selalu set loading true di awal
    isLoadingStatus(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        // Jika token tidak ada, berhenti loading dan mungkin tampilkan pesan
        Get.snackbar('Error', 'Gagal memuat status: Sesi tidak ditemukan.');
        return;
      }

      final response = await service.getAutomationStatus(token);
      automationStatus.value = response.isActive;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        Get.snackbar(
          'Sesi Habis',
          'Gagal memuat status. Silakan login kembali.',
        );
      } else {
        Get.snackbar('Error', 'Gagal memuat status otomatisasi.');
      }
    } finally {
      // Apapun yang terjadi (berhasil atau gagal), hentikan loading
      isLoadingStatus(false);
    }
  }

  // di dalam automation_controller.dart
  Future<void> updateAutomationStatus(bool newStatus) async {
    // Tambahkan state loading khusus untuk update
    // Anda bisa menambahkannya di atas: var isUpdatingStatus = false.obs;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Token tidak ditemukan, silakan login ulang.');
      return;
    }

    try {
      // Panggil service dan TUNGGU responsnya
      final response = await service.updateAutomationStatus(
        token: token,
        isActive: newStatus,
      );

      // JIKA BERHASIL (termasuk parsing), baru update UI dan tampilkan notifikasi sukses
      automationStatus.value = response.isActive;
      SnackbarWidget.showSuccess(
        title: 'Berhasil',
        message: 'Perubahan berhasil dilakukan',
      );
    } catch (e) {
      // Jika ada error apapun (koneksi, parsing, dll), tampilkan pesan error
      SnackbarWidget.showError(
        title: 'Gagal',
        message: 'Perubahan gagal dilakukan',
      );
      // Karena kita tidak melakukan optimistic update, kita tidak perlu mengembalikan state
    }
  }

  /// Mengambil log otomatisasi
  Future<void> getAutomationLog() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      isLoadingLogs(true);
      final response = await service.getAutomationLog(token ?? '');
      automationLogList.assignAll(response.data);
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Terjadi kesalahan saat mengambil data log');
    } finally {
      isLoadingLogs(false);
    }
  }
}
