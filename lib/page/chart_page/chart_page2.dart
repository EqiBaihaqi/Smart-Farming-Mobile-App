// lib/page/chart_page/chart_page.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/model/chart_data_sensor_response_model.dart';
import 'package:smart_farm/controller/chart_controller.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChartController controller = Get.put(ChartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik Sensor Harian'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[50], // Sedikit warna latar belakang
      body: SingleChildScrollView(
        // Membuat seluruh halaman bisa scroll
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Merentangkan child
            children: [
              // --- BARU: Panel Kontrol Terpadu ---
              _buildControlPanel(context, controller),
              const SizedBox(height: 24),
              // --- BARU: Judul Grafik yang Lebih Jelas ---
              Obx(
                () => Text(
                  "${controller.selectedMetric.value.capitalizeFirst!} (${controller.selectedSensor.value.toUpperCase()})",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  "Data untuk: ${controller.displayDate.value}",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
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
                  // --- PERUBAHAN: Memanggil widget grafik yang sudah dipercantik ---
                  return _buildEnhancedChart(controller.chartData);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- BARU: Widget Panel Kontrol ---
  Widget _buildControlPanel(BuildContext context, ChartController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdowns
            Row(
              children: [
                Expanded(child: _buildSensorDropdown(controller)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricDropdown(controller)),
              ],
            ),
            const SizedBox(height: 12),
            // Date Picker Button
            _buildDateSelector(context, controller),
          ],
        ),
      ),
    );
  }

  // --- BARU: Widget Dropdown Sensor yang diekstrak ---
  Widget _buildSensorDropdown(ChartController controller) {
    return Obx(
      () => DropdownButtonFormField<String>(
        value: controller.selectedSensor.value,
        decoration: InputDecoration(
          labelText: 'Sensor',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        items:
            controller.sensorOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.toUpperCase()),
              );
            }).toList(),
        onChanged: controller.onSensorChanged,
      ),
    );
  }

  // --- BARU: Widget Dropdown Metrik yang diekstrak ---
  Widget _buildMetricDropdown(ChartController controller) {
    return Obx(
      () => DropdownButtonFormField<String>(
        value: controller.selectedMetric.value,
        decoration: InputDecoration(
          labelText: 'Metrik',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        items:
            controller.metricOptions[controller.selectedSensor.value]!.map((
              String value,
            ) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.capitalizeFirst!),
              );
            }).toList(),
        onChanged: controller.onMetricChanged,
      ),
    );
  }

  // --- PERUBAHAN: Tombol Tanggal yang lebih baik ---
  Widget _buildDateSelector(BuildContext context, ChartController controller) {
    return Obx(
      () => OutlinedButton.icon(
        icon: const Icon(Icons.calendar_today, size: 18),
        label: Text(controller.displayDate.value),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(45), // Membuat tombol lebih tinggi
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => controller.selectDate(context),
      ),
    );
  }

  // --- PERUBAHAN UTAMA: Widget Grafik yang Dipercantik ---
  Widget _buildEnhancedChart(
    List<ChartDataSensorResponseModel> chartDataPoints,
  ) {
    // Definisikan warna gradien
    final List<Color> gradientColors = [Colors.cyan, Colors.blue];

    return LineChart(
      LineChartData(
        // --- BARU: Tooltip Interaktif ---
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                final timestamp = DateTime.fromMillisecondsSinceEpoch(
                  flSpot.x.toInt(),
                );
                return LineTooltipItem(
                  '${flSpot.y.toStringAsFixed(1)}\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: DateFormat('HH:mm').format(timestamp),
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine:
              (value) => FlLine(
                color: Colors.grey.withValues(alpha: 0.1),
                strokeWidth: 1,
              ),
          getDrawingVerticalLine:
              (value) => FlLine(
                color: Colors.grey.withValues(alpha: 0.1),
                strokeWidth: 1,
              ),
        ),
        titlesData: FlTitlesData(
          // Konfigurasi titles sama seperti sebelumnya, sudah cukup baik
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 3600 * 1000 * 4, // Tampilkan label setiap 4 jam
              getTitlesWidget: (value, meta) {
                final timestamp = DateTime.fromMillisecondsSinceEpoch(
                  value.toInt(),
                );
                return SideTitleWidget(
                  meta: meta,
                  space: 8.0,
                  child: Text(
                    DateFormat('HH:mm').format(timestamp),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots:
                chartDataPoints.map((point) {
                  return FlSpot(
                    point.timestamp.millisecondsSinceEpoch.toDouble(),
                    point.value,
                  );
                }).toList(),
            isCurved: true,
            // --- PERUBAHAN: Menggunakan gradien ---
            gradient: LinearGradient(colors: gradientColors),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            // --- PERUBAHAN: Area di bawah garis juga diberi gradien ---
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors:
                    gradientColors
                        .map((color) => color.withValues(alpha: 0.3))
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
