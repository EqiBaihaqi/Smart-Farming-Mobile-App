import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          image: DecorationImage(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
