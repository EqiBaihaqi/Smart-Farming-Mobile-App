import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/home_controller.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hello,  ',
                  style: whiteTextStyle.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Obx(
                    () => Text(
                      homeController.username.value.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: tealGreenTextstyle.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeDevice.getHeight(context) * 0.015),
            Text(
              'Green house',
              style: whiteTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'test aja sih2, ini tu alamat',
              style: whiteTextStyle.copyWith(fontSize: 12),
            ),
            Text(
              'Ini diisi apa ya',
              style: whiteTextStyle.copyWith(fontSize: 12),
            ),
          ],
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: aquaGreenColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}
