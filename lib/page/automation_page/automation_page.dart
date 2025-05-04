// views/automation_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/automation_controller.dart';

class AutomationPage extends StatelessWidget {
  const AutomationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AutomationController());
    return Scaffold(
      appBar: AppBar(title: const Text('Automation Status'), centerTitle: true),
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Status Card
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color:
                      controller.isAutomationActive.value
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      controller.isAutomationActive.value
                          ? Icons.check_circle
                          : Icons.cancel,
                      color:
                          controller.isAutomationActive.value
                              ? Colors.green
                              : Colors.red,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.isAutomationActive.value
                          ? 'AUTOMATION ACTIVE'
                          : 'AUTOMATION INACTIVE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            controller.isAutomationActive.value
                                ? Colors.green
                                : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
