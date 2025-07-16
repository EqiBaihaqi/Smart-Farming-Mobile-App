import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';
import 'package:smart_farm/controller/automation_controller.dart';
import 'package:smart_farm/page/automation_page/automation_log_shimmer.dart';
import 'package:smart_farm/page/automation_page/automation_log_widget.dart';

class AutomationLog extends StatelessWidget {
  const AutomationLog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AutomationController>();
    return Obx(() {
      if (controller.isLoadingLogs.isTrue) {
        return AutomationLogShimmer();
      }
      if (controller.automationLogList.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text('Belum ada riwayat otomatisasi.'),
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: controller.automationLogList.length,
        itemBuilder: (context, index) {
          final log = controller.automationLogList[index];
          final keputusan = log.state;
          final keputusanColor =
              log.state == 'buka'
                  ? const Color(0xFF3377FF)
                  : log.state == 'NO_ACTION'
                  ? blackColor
                  : Colors.red;

          return Card(
            margin: const EdgeInsets.only(bottom: 24.0),
            color: whiteColor,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  hasIcon: false, // Kita tidak pakai ikon default
                ),
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'WAKTU PELAKASANAAN',
                          style: greyTextStyle.copyWith(fontSize: 12),
                        ),
                        Text(
                          'KEPUTUSAN',
                          style: greyTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          log.executedAt?.toLocal().toString().substring(
                                0,
                                19,
                              ) ??
                              '',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: keputusanColor),
                          ),
                          child: Text(
                            keputusan ?? '',
                            style: TextStyle(
                              color: keputusanColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                collapsed: Container(), // Konten saat tertutup (kosong)
                expanded: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const SizedBox(height: 12),
                      Text(
                        'DETAIL DATA',
                        style: greyTextStyle.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      AutomationLogWidget(
                        title: 'Lokasi Bet',
                        value: '${log.bathchLocationId}',
                      ),
                      AutomationLogWidget(
                        title: 'Kelembaban tanah',
                        value: '${log.npkHumidityInput?.toStringAsFixed(0)} %',
                      ),
                      AutomationLogWidget(
                        title: 'Suhu',
                        value: '${log.npkTemperatureInput} °C',
                      ),

                      AutomationLogWidget(
                        title: 'Durasi',
                        value: '${log.duration} detik',
                      ),
                      AutomationLogWidget(
                        title: 'Berjalan pada',
                        value: log.executedAt?.toLocal().toString().substring(
                                0,
                                19,
                              ) ??
                              '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
