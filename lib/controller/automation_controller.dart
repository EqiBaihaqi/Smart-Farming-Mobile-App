// controllers/automation_controller.dart
import 'package:get/get.dart';

class AutomationController extends GetxController {
  final isAutomationActive = false.obs;

  void toggleAutomation() {
    isAutomationActive.toggle();
    // Add your actual automation logic here (API calls, device commands, etc.)
  }
}