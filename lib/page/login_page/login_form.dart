import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/auth_controller.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) => value!.isEmpty ? 'Masukkan email' : null,
          ),
          const SizedBox(height: 15),

          // Password Field
          TextFormField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) => value!.isEmpty ? 'Masukkan password' : null,
          ),
          const SizedBox(height: 20),

          // Error Message & Login Button
          Obx(() {
            if (authController.errorMessage.isNotEmpty) {
              return Text(
                authController.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }
}
