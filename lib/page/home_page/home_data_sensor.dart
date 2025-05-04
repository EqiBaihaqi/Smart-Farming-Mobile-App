import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/page/home_page/home_data_dht_sensor.dart';
import 'package:smart_farm/page/home_page/home_data_npk1_sensor.dart';
import 'package:smart_farm/page/home_page/home_data_npk2_sensor.dart';

class HomeDataSensor extends StatefulWidget {
  const HomeDataSensor({super.key});

  @override
  State<HomeDataSensor> createState() => _HomeDataSensorState();
}

class _HomeDataSensorState extends State<HomeDataSensor> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> sensors = [
      HomeDataDhtSensor(),
      HomeDataNpk1Sensor(),
      HomeDataNpk2Sensor(),
    ];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeDevice.getWidth(context) * 0.08,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(sensors.length, (index) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                style: ElevatedButton.styleFrom(
                  overlayColor: greyColor.withValues(alpha: 0.2),
                  elevation: 4, // Default elevation
                  shadowColor: Colors.black12,
                  backgroundColor:
                      selectedIndex == index ? greyColor : whiteColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                ),
                child: Text(
                  index == 0
                      ? 'DHT'
                      : index == 1
                      ? 'NPK 1'
                      : 'NPK 2',
                  style: blackTextStyle.copyWith(
                    color: selectedIndex == index ? whiteColor : blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
        ),
        Gap(20),
        sensors[selectedIndex],
      ],
    );
  }
}
