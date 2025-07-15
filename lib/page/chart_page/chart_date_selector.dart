import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/chart_controller.dart';

class ChartDateSelector extends StatelessWidget {
  const ChartDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChartController>();
    return Obx(
      () => OutlinedButton.icon(
        icon: const Icon(Icons.calendar_today, size: 18),
        label: Text(
          controller.displayDate.value,
          style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed:
            () =>
                controller.isLoading.value
                    ? null
                    : controller.selectDate(context),
      ),
    );
  }
}
