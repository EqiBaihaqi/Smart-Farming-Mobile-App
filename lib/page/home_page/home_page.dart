import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/home_controller.dart';
import 'package:smart_farm/page/home_page/home_data_sensor.dart';
import 'package:smart_farm/page/home_page/home_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeDevice.getHeight(context) * 0.35,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: SizeDevice.getHeight(context) * 0.31,
                      child: Container(
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(300, 75),
                            bottomRight: Radius.elliptical(300, 75),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: SizeDevice.getHeight(context) * 0.11,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeDevice.getWidth(context) * 0.05,
                        ),
                        child: HomeHeader(),
                      ),
                    ),

                    // Refresh Button
                    Positioned(
                      top: SizeDevice.getHeight(context) * 0.292,
                      left: SizeDevice.getWidth(context) * 0.87,
                      child: Obx(
                        () => IconButton(
                          onPressed:
                              homeController.isLoadingSensor.value
                                  ? null // Disable button during loading
                                  : () => homeController.getLatestSensorData(),
                          icon:
                              homeController.isLoadingSensor.value
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  ) // Show loader on button
                                  : FaIcon(FontAwesomeIcons.arrowRotateRight),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeDevice.getWidth(context) * 0.03,
                ),
                child: HomeDataSensor(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
