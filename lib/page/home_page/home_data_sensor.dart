import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/page/home_page/home_data_dht1_sensor.dart';
import 'package:smart_farm/page/home_page/home_data_dht2_sensor.dart';
import 'package:smart_farm/page/home_page/home_data_npk_sensor.dart';

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
      HomeDataDht1Sensor(),
      HomeDataDht2Sensor(),
      HomeDataNpkSensor(),
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(sensors.length, (index) {
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedIndex == index ? greyColor : whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              ),
              child: Text(
                index == 0
                    ? 'DHT 1'
                    : index == 1
                    ? 'DHT 2'
                    : 'Npk',
                style: blackTextStyle.copyWith(
                  color: selectedIndex == index ? whiteColor : blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ),
        Gap(20),
        sensors[selectedIndex],
      ],
    );
  }
}
