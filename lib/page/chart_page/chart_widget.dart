import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/model/chart_data_sensor_response_model.dart';

class ChartWidget extends StatelessWidget {
  final List<ChartDataSensorResponseModel> chartDataPoints;

  const ChartWidget({super.key, required this.chartDataPoints});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: SizedBox(height: 400, child: _buildChart()));
  }

  Widget _buildChart() {
    final validData = chartDataPoints.toList();
    if (validData.isEmpty) return _buildNoDataWidget();
    final displayData =
        validData.length > 50
            ? _downsampleData(validData, targetCount: 30)
            : validData;

    final minX = displayData.first.timestamp.millisecondsSinceEpoch.toDouble();
    final maxX = displayData.last.timestamp.millisecondsSinceEpoch.toDouble();
    final yValues = displayData.map((p) => p.value).toList();
    final minY = yValues.reduce(min) * 0.95; 
    final maxY = yValues.reduce(max) * 1.05; 

    return LineChart(
      LineChartData(
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,

        // 4. Nonaktifkan fitur yang tidak penting
        gridData: FlGridData(show: true), // Matikan grid untuk performa
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              minIncluded: false,
              maxIncluded: false,
              showTitles: true,
              interval: 3600 * 1000 * 3, // Label setiap 3 jam
              getTitlesWidget: (value, _) {
                return Text(
                  DateFormat(
                    'HH:mm',
                  ).format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              minIncluded: false,
              showTitles: true,
              interval: (maxY - minY) / 3,
              getTitlesWidget: (value, _) => Text(value.toStringAsFixed(1)),
            ),
          ),
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
        ),
        lineBarsData: [
          LineChartBarData(
            spots:
                displayData
                    .map(
                      (p) => FlSpot(
                        p.timestamp.millisecondsSinceEpoch.toDouble(),
                        p.value,
                      ),
                    )
                    .toList(),
            isCurved: true, // Matikan kurva untuk performa
            barWidth: 3,

            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            maxContentWidth: 120,
            getTooltipItems:
                (spots) =>
                    spots.map((spot) {
                      return LineTooltipItem(
                        '${spot.y.toStringAsFixed(1)}\n${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(spot.x.toInt()))}',
                        const TextStyle(fontSize: 12),
                      );
                    }).toList(),
          ),
        ),
      ),
      // 5. Optimasi animasi
      duration: const Duration(milliseconds: 0), // Nonaktifkan animasi
    );
  }

  List<ChartDataSensorResponseModel> _downsampleData(
    List<ChartDataSensorResponseModel> data, {
    required int targetCount,
  }) {
    if (data.length <= targetCount) return data;

    final step = (data.length / targetCount).ceil();
    return List.generate(
      targetCount,
      (i) => data[i * step],
    ).whereType<ChartDataSensorResponseModel>().toList();
  }

  Widget _buildNoDataWidget() {
    return const Center(child: Text('Tidak ada data valid'));
  }
}
