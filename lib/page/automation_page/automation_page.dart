// views/automation_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart'; // Sesuaikan path jika perlu
import 'package:smart_farm/controller/automation_controller.dart';
import 'package:smart_farm/page/automation_page/automation_log.dart';
import 'package:smart_farm/page/automation_page/automation_status.dart';

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
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.getAutomationLog();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutomationStatus(),
                const SizedBox(height: 20),
                Divider(),
                const SizedBox(height: 10),
                Text(
                  'Log Otomatisasi',
                  style: defaultTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                AutomationLog(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
