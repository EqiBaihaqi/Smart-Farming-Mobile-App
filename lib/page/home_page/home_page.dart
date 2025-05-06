import 'package:flutter/material.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/page/home_page/home_data_sensor.dart';
import 'package:smart_farm/page/home_page/home_header.dart';
import 'package:smart_farm/page/home_page/home_logout_button.dart';
import 'package:smart_farm/page/home_page/home_toggle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      top: SizeDevice.getHeight(context) * 0.08,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeDevice.getWidth(context) * 0.05,
                        ),
                        child: HomeHeader(),
                      ),
                    ),
                    Positioned(
                      top: SizeDevice.getHeight(context) * 0.272,
                      left: SizeDevice.getWidth(context) * 0.32,
                      right: SizeDevice.getWidth(context) * 0.32,
                      child: HomeToggle(),
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
