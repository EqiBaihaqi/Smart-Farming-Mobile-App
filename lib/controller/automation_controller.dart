// controllers/automation_controller.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/model/automation_log_response_model.dart';
import 'package:smart_farm/service/automation_service.dart';
import 'package:smart_farm/widget/snackbar_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
    updateDisplayDate();
  }

  // Mengambil status otomasi terbaru dari server
  Future<void> getAutomationStatus() async {
    // Selalu set loading true di awal
    isLoadingStatus(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        // Jika token tidak ada, berhenti loading dan mungkin tampilkan pesan
        SnackbarWidget.showError(
          title: 'Error',
          message: 'Gagal memuat status: Sesi tidak ditemukan.',
        );
        return;
      }

      final response = await service.getAutomationStatus(token);
      automationStatus.value = response.isActive;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        SnackbarWidget.showInfo(
          title: 'Sesi Habis',
          message: 'Gagal memuat status. silahkan login kembali',
        );
      } else {
        SnackbarWidget.showError(
          title: 'Error',
          message: 'Gagal memuat status otomatisasi.',
        );
      }
    } finally {
      // Apapun yang terjadi (berhasil atau gagal), hentikan loading
      isLoadingStatus(false);
    }
  }

  // di dalam automation_controller.dart
  // Future<void> updateAutomationStatus(bool newStatus) async {
  //   // Tambahkan state loading khusus untuk update
  //   // Anda bisa menambahkannya di atas: var isUpdatingStatus = false.obs;

  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');

  //   if (token == null || token.isEmpty) {
  //     Get.snackbar('Error', 'Token tidak ditemukan, silakan login ulang.');
  //     return;
  //   }

  //   try {
  //     // Panggil service dan TUNGGU responsnya
  //     final response = await service.updateAutomationStatus(
  //       token: token,
  //       isActive: newStatus,
  //     );

  //     // JIKA BERHASIL (termasuk parsing), baru update UI dan tampilkan notifikasi sukses
  //     automationStatus.value = response.isActive;
  //     SnackbarWidget.showSuccess(
  //       title: 'Berhasil',
  //       message: 'Perubahan berhasil dilakukan',
  //     );
  //   } catch (e) {
  //     // Jika ada error apapun (koneksi, parsing, dll), tampilkan pesan error
  //     SnackbarWidget.showError(
  //       title: 'Gagal',
  //       message: 'Perubahan gagal dilakukan',
  //     );
  //     // Karena kita tidak melakukan optimistic update, kita tidak perlu mengembalikan state
  //   }
  // }
  var selectedDate = DateTime.now().obs;
  // Mengambil log otomatisasi
  Future<void> getAutomationLog() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      isLoadingLogs(true);
      final response = await service.getAutomationLog(
        token ?? '',
        selectedDate.value,
      );
      automationLogList.assignAll(response.logs);
    } catch (e) {
      SnackbarWidget.showError(
        title: 'Error',
        message: 'Terjadi kesalahan saat mengambil data log',
      );
      print(e);
    } finally {
      isLoadingLogs(false);
    }
  }

  // memilih tanggal
  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = selectedDate.value;

    await Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                initialSelectedDate: selectedDate.value,
                maxDate:
                    DateTime.now(), // Pengguna tidak bisa memilih hari di masa depan
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is DateTime) {
                    pickedDate = args.value;
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      if (pickedDate != null) {
                        selectedDate.value = pickedDate!;
                        updateDisplayDate(); // Perbarui teks tanggal
                        getAutomationLog(); // Ambil data log baru
                      }
                      Get.back(); // Tutup dialog
                      updateDisplayDate();
                    },
                    child: const Text('Pilih'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  var displayDate = ''.obs;
  // Update date view
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
}
