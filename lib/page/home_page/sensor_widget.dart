import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';

class SensorWidget extends StatelessWidget {
  const SensorWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.description,
    required this.color,
    this.isLoading = false,
  });
  final String? value;
  final String description;
  final IconData icon;
  final Color color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(icon, size: 43, color: color),
        Gap(6),
        Text(
          description,
          style: greyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Gap(6),
        Text(
          value ?? '0',
          style: blackTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
