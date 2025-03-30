import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: SizeDevice.getHeight(context) * 0.31,
              child: Container(
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(300, 75),
                    bottomRight: Radius.elliptical(300, 75),
                  ),
                ),
              ),
            ),
            Positioned(
              top: SizeDevice.getHeight(context) * 0.01,
              right: 0,
              child: TextButton(
                onPressed: () {
                  authController.logout();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: redColor, width: 2.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 6.0,
                    ),
                    child: Text(
                      'Log out',
                      style: whiteTextStyle.copyWith(
                        color: redColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: SizeDevice.getHeight(context) * 0.08,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeDevice.getWidth(context) * 0.05,
                ),
                child: Row(
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
                              child: Text(
                                'Baihaqi',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: tealGreenTextstyle.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
