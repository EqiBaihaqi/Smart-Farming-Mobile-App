import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  color: blueColor,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: SizeDevice.getHeight(context) * 0.3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(150, 35),
                    bottomRight: Radius.elliptical(150, 35),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/greenhouse.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: SizeDevice.getHeight(context) * 0.32,
              right: 0,
              left: 0,
              child: Center(
                child: Text(
                  'Selamat Datang!',
                  style: blackTextStyle.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: SizeDevice.getHeight(context) * 0.5,
              left: 2,
              right: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SignInButton(
                  Buttons.google,
                  onPressed: () {
                    authController.loginWithGoogle();
                  },
                  elevation: 6,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
