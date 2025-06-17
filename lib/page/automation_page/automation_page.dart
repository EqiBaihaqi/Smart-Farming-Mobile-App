// views/automation_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart'; // Sesuaikan path jika perlu
import 'package:smart_farm/controller/automation_controller.dart';
import 'package:smart_farm/page/automation_page/automation_log.dart';
import 'package:switcher_button/switcher_button.dart';

class AutomationPage extends StatelessWidget {
  const AutomationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AutomationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Otomatisasi',
          style: blackTextStyle.copyWith(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- KARTU STATUS OTOMATISASI (TIDAK BERUBAH) ---
              Container(
                height: 80,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'STATUS OTOMATISASI',
                        style: defaultTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() {
                        if (controller.isLoadingStatus.isTrue) {
                          return const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          );
                        }
                        return SwitcherButton(
                          value: controller.automationStatus.value ?? false,
                          offColor: greyColor,
                          onColor: indigoColor,
                          onChange: (value) {
                            controller.updateAutomationStatus(value);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Divider(),
              const SizedBox(height: 20),
              AutomationLog(),
            ],
          ),
        ),
      ),
    );
  }
}
