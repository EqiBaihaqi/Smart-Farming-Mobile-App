import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/chart_controller.dart';

class ChartSensorDropdown extends StatelessWidget {
  const ChartSensorDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChartController>();
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
                child: Text(
                  value.toUpperCase(),
                  style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
        onChanged:
            controller.isLoading.value ? null : controller.onSensorChanged,
      ),
    );
  }
}
