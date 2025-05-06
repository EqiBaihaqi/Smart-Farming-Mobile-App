import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/home_controller.dart';
import 'package:smart_farm/page/home_page/sensor_widget.dart';

class HomeDataNpk1Sensor extends StatelessWidget {
  const HomeDataNpk1Sensor({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
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
          Center(
            child: Text(
              'Soil Sensor',
              style: defaultTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Obx(
            () =>
                homeController.isLoadingSensor.value
                    ? CircularProgressIndicator()
                    : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeDevice.getWidth(context) * 0.05,
                            vertical: SizeDevice.getHeight(context) * 0.03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SensorWidget(
                                description: 'Temperature',
                                value: '${homeController.npk1Temp.value}',
                                icon: FontAwesomeIcons.thermometer,
                                color: redColor,
                                isLoading: homeController.isLoadingSensor.value,
                              ),
                              SensorWidget(
                                description: 'Humidity',
                                value: '${homeController.npk1Humi.value}',
                                icon: FontAwesomeIcons.water,
                                color: softBlue,
                                isLoading: homeController.isLoadingSensor.value,
                              ),
                              SensorWidget(
                                description: 'Conductivity',
                                value: '${homeController.npk1Conduct.value}',
                                icon: FontAwesomeIcons.bolt,
                                color: Colors.purple,
                                isLoading: homeController.isLoadingSensor.value,
                              ),
                              SensorWidget(
                                description: 'pH',
                                value: '${homeController.npk1Ph.value}',
                                icon: FontAwesomeIcons.vial,
                                color: blueColor,
                                isLoading: homeController.isLoadingSensor.value,
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
                                description: 'Nitrogen',
                                value: '${homeController.npk1Nitro.value}',
                                icon: FontAwesomeIcons.leaf,
                                color: greenColor,
                                isLoading: homeController.isLoadingSensor.value,
                              ),
                              SensorWidget(
                                description: 'Phosporus',
                                value: '${homeController.npk1Phos.value}',
                                icon: FontAwesomeIcons.fireFlameCurved,
                                color: Colors.orange,
                                isLoading: homeController.isLoadingSensor.value,
                              ),
                              SensorWidget(
                                description: 'Potassium',
                                value: '${homeController.npk1Phos.value}',
                                icon: FontAwesomeIcons.boltLightning,
                                color: Colors.yellow,
                                isLoading: homeController.isLoadingSensor.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
