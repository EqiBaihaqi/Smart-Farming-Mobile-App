import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/auth_controller.dart';
import 'package:smart_farm/page/login_page/login_form.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              child: Container(decoration: BoxDecoration(color: blueColor)),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: SizeDevice.getHeight(context) * 0.24,
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
              top: SizeDevice.getHeight(context) * 0.28,
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
              top: SizeDevice.getHeight(context) * 0.37,
              left: 20,
              right: 20,
              child: LoginForm(
                emailController: emailController,
                passwordController: passwordController,
                formKey: formKey,
              ),
            ),
            // Login Button (Positioned below the form)
            Positioned(
              top: SizeDevice.getHeight(context) * 0.55,
              left: 20,
              right: 20,
              child: Obx(() {
                return authController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                      onPressed: submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
              }),
            ),
            Positioned(
              top: SizeDevice.getHeight(context) * 0.64,
              left: 20,
              right: 20,
              child: Obx(() {
                if (authController.errorMessage.isNotEmpty) {
                  return Text(
                    authController.errorMessage.value,
                    style: defaultTextStyle.copyWith(color: redColor),
                  );
                }
                return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      final controller = Get.find<AuthController>();
      controller.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }
}
