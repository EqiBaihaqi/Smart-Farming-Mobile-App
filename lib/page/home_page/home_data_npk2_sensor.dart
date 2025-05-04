import 'package:flutter/material.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/page/home_page/sensor_widget.dart';

class HomeDataNpk2Sensor extends StatelessWidget {
  const HomeDataNpk2Sensor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeDevice.getHeight(context) * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2), // Shadow color
            spreadRadius: 2, // How far the shadow spreads
            blurRadius: 5, // How blurry the shadow is
            offset: Offset(0, 3), // Shadow position (x, y)
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeDevice.getWidth(context) * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SensorWidget(
                  description: 'kiwkiw',
                  value: '12',
                  icon: Icons.abc,
                ),
                SensorWidget(
                  description: 'kiwkiw',
                  value: '12',
                  icon: Icons.youtube_searched_for_sharp,
                ),
                SensorWidget(
                  description: 'kiwkiw',
                  value: '12',
                  icon: Icons.zoom_out_map,
                ),
                SensorWidget(
                  description: 'kiwkiw',
                  value: '12',
                  icon: Icons.ac_unit_rounded,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeDevice.getWidth(context) * 0.17,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SensorWidget(
                  description: 'kiwkiw',
                  value: '12',
                  icon: Icons.abc,
                ),
                SensorWidget(
                  description: 'kiwkiw',
                  value: '12',
                  icon: Icons.youtube_searched_for_sharp,
                ),
                SensorWidget(
                  description: 'kiwkiw',
                  value: '12',
                  icon: Icons.zoom_out_map,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
