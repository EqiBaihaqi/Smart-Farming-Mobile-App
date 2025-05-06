import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/home_controller.dart';

class ProfileInformasiAkunDetail extends StatelessWidget {
  const ProfileInformasiAkunDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Akun'),
        toolbarHeight: SizeDevice.getHeight(context) * 0.07,
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(15),
            Divider(height: 3, color: greyColor),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Username : ${homeController.username.value}',
                style: defaultTextStyle.copyWith(fontSize: 20),
              ),
            ),
            Divider(height: 3, color: greyColor),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Fullname : ${homeController.fullname.value}',
                style: defaultTextStyle.copyWith(fontSize: 20),
              ),
            ),
            Divider(height: 3, color: greyColor),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Email : ${homeController.email.value}',
                style: defaultTextStyle.copyWith(fontSize: 20),
              ),
            ),
            Divider(height: 3, color: greyColor),
          ],
        ),
      ),
    );
  }
}
