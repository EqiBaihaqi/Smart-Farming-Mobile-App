import 'package:flutter/material.dart';

class AutomationLogWidget extends StatelessWidget {
  final String title;
  final String value;
  const AutomationLogWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return // Helper widget untuk baris detail
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4D8), // Warna kuning dari desain
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFFFD66C),
              ), // Border kuning
            ),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          const Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
