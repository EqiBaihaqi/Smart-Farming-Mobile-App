import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/automation_controller.dart';

class AutomationStatus extends StatelessWidget {
  const AutomationStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AutomationController>();
    return Container(
      height: SizeDevice.getHeight(context) * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() {
              if (controller.automationStatus.value == true) {
                return Text(
                  'Otomatisasi Aktif',
                  style: defaultTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return Text(
                'Otomatisasi Tidak Aktif',
                style: defaultTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            Obx(() {
              if (controller.automationStatus.value == true) {
                return Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                );
              }
              return Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
