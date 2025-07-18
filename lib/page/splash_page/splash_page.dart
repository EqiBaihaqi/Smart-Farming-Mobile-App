import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Container(
      color: foundationBlueColor,
      child: Center(
        child: Container(
          width: SizeDevice.getWidth(context) * 0.6,
          height: SizeDevice.getHeight(context) * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/agrilink-vocpro-logo-new.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
