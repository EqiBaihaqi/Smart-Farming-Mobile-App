import 'package:flutter/material.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';

class SensorWidget extends StatelessWidget {
  const SensorWidget({
    super.key,
    this.icon,
    required this.value,
    required this.description,
  });
  final String value;
  final String description;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 55),
        Text(
          description,
          style: greyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: blackTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
