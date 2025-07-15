import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/chart_controller.dart';
import 'package:smart_farm/page/chart_page/chart_control_panel.dart';
import 'package:smart_farm/page/chart_page/chart_widget.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChartController controller = Get.put(ChartController());

    return SafeArea(
      minimum: EdgeInsets.only(top: SizeDevice.getHeight(context) * 0.02),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: SizeDevice.getHeight(context) * 0.1,
          title: Text(
            'Grafik Sensor Harian',
            style: defaultTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        backgroundColor: Colors.grey[50], // Sedikit warna latar belakang
        body: SingleChildScrollView(
          // Membuat seluruh halaman bisa scroll
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Merentangkan child
              children: [
                ChartControlPanel(),
                const SizedBox(height: 24),
                // --- BARU: Judul Grafik yang Lebih Jelas ---
                Obx(
                  () => Text(
                    "${controller.selectedMetric.value.capitalizeFirst!} (${controller.selectedSensor.value.toUpperCase()})",
                    style: defaultTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    "Data untuk: ${controller.displayDate.value}",
                    style: defaultTextStyle.copyWith(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Area Grafik
                SizedBox(
                  height: 300, // Memberi tinggi yang tetap pada area grafik
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.chartData.isEmpty) {
                      return Center(
                        child: Text(
                          'Tidak ada data untuk ditampilkan.',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      );
                    }

                    return ChartWidget(chartDataPoints: controller.chartData);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
