import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/control_controller.dart';
import 'package:smart_farm/page/control_page/control_actuator_card.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  // Di dalam file control_page.dart

  // ... (kode import dan class lainnya)

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ControlController());

    return SafeArea(
      minimum: EdgeInsets.only(top: SizeDevice.getHeight(context) * 0.02),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Kontrol Aktuator',
            style: defaultTextStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          toolbarHeight: SizeDevice.getHeight(context) * 0.1,
        ), // 1. Bungkus dengan Obx agar UI reaktif terhadap perubahan di controller
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchInitialStatus();
          },
          child: Obx(() {
            // Handle loading halaman awal dan error
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.errorMessage.isNotEmpty) {
              return SizedBox(
                width: double.infinity,
                height: SizeDevice.getHeight(context) * 0.7,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: defaultTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            // Tampilkan UI utama
            return ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              ControlActuatorCard(
                                title: 'PUMP',
                                assetIcon: 'assets/pump.png',
                                boolVariable: controller.isPumpOn.value,
                                // Nonaktifkan tombol saat loading untuk mencegah double-tap
                                onChanged: (b) => controller.togglePump(b),
                              ),
                              // Tampilkan overlay jika 'Pump' sedang dieksekusi
                              if (controller.executingActuators.contains(
                                'Pump',
                              ))
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.4,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Stack(
                            children: [
                              ControlActuatorCard(
                                title: 'NUTRIENT',
                                assetIcon: 'assets/plant.png',
                                boolVariable:
                                    controller.isNutrientValveOn.value,
                                onChanged:
                                    (b) => controller.toggleNutrientValve(b),
                              ),
                              if (controller.executingActuators.contains(
                                'Nutrient Valve',
                              ))
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.4,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(6),

                      Stack(
                        children: [
                          ControlActuatorCard(
                            title: 'WATER',
                            assetIcon: 'assets/water.png',
                            boolVariable: controller.isWaterValveOn.value,
                            onChanged: (b) => controller.toggleWaterValve(b),
                          ),
                          if (controller.executingActuators.contains(
                            'Water Valve',
                          ))
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
