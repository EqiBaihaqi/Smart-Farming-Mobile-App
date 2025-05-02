import 'package:flutter/material.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';

class HomeDataDht1Sensor extends StatelessWidget {
  const HomeDataDht1Sensor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeDevice.getHeight(context) * 0.43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: blueColor,
      ),
    );
  }
}
