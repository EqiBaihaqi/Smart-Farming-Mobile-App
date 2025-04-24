import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: blueColor,
      body: Center(
        child: Text(
          'aw',
          style: defaultTextStyle.copyWith(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
