import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/auth_controller.dart';

class HomeLogoutButton extends StatelessWidget {
  const HomeLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return TextButton(
      onPressed: () {
        authController.logout();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: redColor, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Text(
            'Log out',
            style: whiteTextStyle.copyWith(
              color: redColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
