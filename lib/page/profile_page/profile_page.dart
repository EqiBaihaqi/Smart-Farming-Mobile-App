import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/home_controller.dart';
import 'package:smart_farm/page/profile_page/profile_informasi_akun_button.dart';
import 'package:smart_farm/page/profile_page/profile_keluar_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: defaultTextStyle),
        toolbarHeight: SizeDevice.getHeight(context) * 0.07,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: greyColor.withValues(alpha: 0.3),
            backgroundImage: AssetImage('assets/profile_icon.png'),
            radius: 60,
          ),
          Gap(25),
          Center(
            child: Obx(
              () => Text(
                homeController.username.value,
                style: defaultTextStyle.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Gap(20),
          Divider(height: 3, color: greyColor),
          ProfileInformasiAkunButton(),
          Divider(height: 3, color: greyColor),
          ProfileKeluarButton(),
          Divider(height: 3, color: greyColor),
        ],
      ),
    );
  }
}
