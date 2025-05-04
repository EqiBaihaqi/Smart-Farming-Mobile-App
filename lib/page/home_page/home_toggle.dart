import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/home_controller.dart';

class HomeToggle extends StatelessWidget {
  const HomeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Obx(
      () => SizedBox(
        width: 350,
        child: AnimatedToggleSwitch<bool>.dual(
          current: homeController.isIrrigationOn.value,
          first: false,
          second: true,
          style: const ToggleStyle(
            borderColor: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
          ),
          borderWidth: 5.0,
          spacing: 50.0,
          height: 55,
          onChanged: (b) async {
            if (b) {
              await homeController.turnOnIrrigation();
            } else {
              await homeController.turnOffIrrigation();
            }
          },
          styleBuilder:
              (b) => ToggleStyle(indicatorColor: b ? greenColor : redColor),
          iconBuilder:
              (value) =>
                  value
                      ? const Icon(Icons.power_outlined)
                      : const Icon(Icons.power_off_rounded),
          textBuilder:
              (value) =>
                  value
                      ? const Center(
                        child: Text(
                          'Irigasi Nyala',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                      : const Center(
                        child: Text(
                          'Irigasi Mati',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
        ),
      ),
    );
  }
}
