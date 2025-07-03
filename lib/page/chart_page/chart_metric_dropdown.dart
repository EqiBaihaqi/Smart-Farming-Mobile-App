// lib/ui/widget/chart_metric_dropdown.dart (contoh path)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/chart_controller.dart';

class ChartMetricDropdown extends StatelessWidget {
  const ChartMetricDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChartController>();

    return Obx(() {
      final validMetrics =
          controller.metricOptions[controller.selectedSensor.value] ?? [];
      final currentMetric = controller.selectedMetric.value;

      if (validMetrics.isEmpty || !validMetrics.contains(currentMetric)) {
        // Tampilkan loading kecil selagi controller memperbaiki state
        return SizedBox(
          height: 59, // Tinggi default DropdownButtonFormField
          child: Center(
            child: Transform.scale(
              scale: 0.6,
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      }

      // Jika state aman, render Dropdown seperti biasa
      return DropdownButtonFormField<String>(
        value: currentMetric,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Metrik',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
        ),
        items:
            validMetrics.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  controller.metricLabels[value] ?? value,
                  style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
        onChanged: controller.onMetricChanged,
      );
    });
  }
}
