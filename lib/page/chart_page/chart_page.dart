import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/sensor_controller.dart';
import 'package:smart_farm/model/npk_data_response_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NpkChartPage extends StatelessWidget {
  const NpkChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SensorController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Grafik NPK"),
        actions: [
          IconButton(
            onPressed: () {
              controller.loadNpk1GrapchicData();
              controller.loadNpk2GrapchicData();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.npk1List.isEmpty) {
          return Center(child: Text("Data tidak tersedia"));
        }

        return Column(
          children: [
            // NPK1 DATA GRAPH
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Grafik Data NPK1'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                LineSeries<NpkDataModel, String>(
                  name: 'Temp',
                  dataSource: controller.npk1List,
                  xValueMapper: (data, _) => '${data.hour}h',
                  yValueMapper: (data, _) => data.soilTemperature,
                ),
                LineSeries<NpkDataModel, String>(
                  name: 'Humidity',
                  dataSource: controller.npk1List,
                  xValueMapper: (data, _) => '${data.hour}h',
                  yValueMapper: (data, _) => data.soilHumidity,
                ),
                LineSeries<NpkDataModel, String>(
                  name: 'Conductivity',
                  dataSource: controller.npk1List,
                  xValueMapper: (data, _) => '${data.hour}h',
                  yValueMapper: (data, _) => data.soilConductivity,
                ),
              ],
            ),
            Gap(3),
            // NPK2 DATA GRAPH
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Grafik Data NPK1'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                LineSeries<NpkDataModel, String>(
                  name: 'Temp',
                  dataSource: controller.npk2List,
                  xValueMapper: (data, _) => '${data.hour}h',
                  yValueMapper: (data, _) => data.soilTemperature,
                ),
                LineSeries<NpkDataModel, String>(
                  name: 'Humidity',
                  dataSource: controller.npk2List,
                  xValueMapper: (data, _) => '${data.hour}h',
                  yValueMapper: (data, _) => data.soilHumidity,
                ),
                LineSeries<NpkDataModel, String>(
                  name: 'Conductivity',
                  dataSource: controller.npk2List,
                  xValueMapper: (data, _) => '${data.hour}h',
                  yValueMapper: (data, _) => data.soilConductivity,
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
