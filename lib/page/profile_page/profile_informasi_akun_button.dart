import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/page/profile_page/profile_informasi_akun_detail.dart';

class ProfileInformasiAkunButton extends StatelessWidget {
  const ProfileInformasiAkunButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProfileInformasiAkunDetail());
      },
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 32),
                Gap(8),
                Text(
                  'Informasi Akun',
                  style: defaultTextStyle.copyWith(fontSize: 20),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_right, size: 32),
          ],
        ),
      ),
    );
  }
}
