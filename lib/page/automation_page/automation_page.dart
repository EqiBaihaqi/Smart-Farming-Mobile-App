// views/automation_page.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

    return SafeArea(
      minimum: EdgeInsets.only(top: SizeDevice.getHeight(context) * 0.02),
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.getAutomationLog();
          await controller.getAutomationStatus();
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: SizeDevice.getHeight(context) * 0.1,
            title: Text(
              'Otomatisasi Irigasi',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Log Otomatisasi',
                                style: defaultTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Gap(5),
                              Text(
                                controller.displayDate.value,
                                style: greyTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              controller.selectDate(context);
                            },
                            icon: Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    AutomationLog(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
