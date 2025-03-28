import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('Home Page ni')),
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
