import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/home_controller.dart';
import 'package:smart_farm/page/home_page/sensor_widget.dart';

class HomeDataDhtSensor extends StatelessWidget {
  const HomeDataDhtSensor({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Container(
      width: double.infinity,
      height: SizeDevice.getHeight(context) * 0.2,
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
              vertical: SizeDevice.getHeight(context) * 0.01,
            ),
            child: Center(
              child: Text(
                'Vicinity Sensor',
                style: defaultTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeDevice.getWidth(context) * 0.025,
              vertical: SizeDevice.getHeight(context) * 0.01,
            ),
            child: Obx(
              () =>
                  homeController.isLoadingSensor.value
                      ? CircularProgressIndicator()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SensorWidget(
                            description: 'Temperature',
                            value: '${homeController.dhtTemp.value}',
                            icon: FontAwesomeIcons.thermometer,
                            color: redColor,
                            isLoading: homeController.isLoadingSensor.value,
                          ),
                          SensorWidget(
                            description: 'Humidity',
                            value: '${homeController.dhtHumi.value}',
                            icon: FontAwesomeIcons.water,
                            color: softBlue,
                            isLoading: homeController.isLoadingSensor.value,
                          ),
                          SensorWidget(
                            description: 'Luminosity',
                            value: '${homeController.dhtLumi.value}',
                            icon: FontAwesomeIcons.sun,
                            color: Colors.yellow,
                            isLoading: homeController.isLoadingSensor.value,
                          ),
                        ],
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
