class IrrigationService {
  // Dummy API simulation
Future<bool> turnOnIrrigation() async {
  await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
  final randomSuccess = (DateTime.now().second % 2) == 0; // 50% success rate
  return randomSuccess;
}

Future<bool> turnOffIrrigation() async {
  await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
  final randomSuccess = (DateTime.now().second % 3) == 0; // 33% success rate
  return randomSuccess;
}

}