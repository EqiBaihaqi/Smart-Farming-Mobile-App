import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/auth_controller.dart';


class ProfileKeluarButton extends StatelessWidget {
  const ProfileKeluarButton({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(
                  'Anda yakin ingin keluar?',
                  style: defaultTextStyle,
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await authController.logout();
                      },

                      child: Container(
                        width: SizeDevice.getWidth(context) * 0.3,
                        height: SizeDevice.getHeight(context) * 0.07,
                        decoration: BoxDecoration(
                          color: redColor,
                          border: Border.all(color: blackColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Ya',
                            style: defaultTextStyle.copyWith(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: SizeDevice.getWidth(context) * 0.3,
                        height: SizeDevice.getHeight(context) * 0.07,
                        decoration: BoxDecoration(
                          color: greyColor,
                          border: Border.all(color: blackColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Tidak',
                            style: defaultTextStyle.copyWith(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(Icons.logout_outlined, size: 32, color: redColor),
            Gap(8),
            Text(
              'Keluar',
              style: defaultTextStyle.copyWith(fontSize: 20, color: redColor),
            ),
          ],
        ),
      ),
    );
  }
}
