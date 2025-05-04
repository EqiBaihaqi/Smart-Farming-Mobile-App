import 'package:flutter/material.dart';
import 'package:smart_farm/controller/sensor_controller.dart';
import 'package:smart_farm/model/sensor_data_mode.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SensorController());
    return Scaffold(
      appBar: AppBar(title: Text('Charts')),
      body: Container(
        height: 300,
        padding: const EdgeInsets.all(8),
        child: SfCartesianChart(
          title: ChartTitle(text: 'All Sensor Data'),
          legend: Legend(isVisible: true, position: LegendPosition.top),
          primaryXAxis: DateTimeAxis(
            dateFormat: DateFormat.Hm(),
            title: AxisTitle(text: 'Time'),
          ),
          primaryYAxis: NumericAxis(title: AxisTitle(text: 'Values')),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<dynamic, dynamic>>[
            LineSeries<SensorData, DateTime>(
              dataSource: controller.sensorData,
              xValueMapper: (SensorData data, _) => data.time,
              yValueMapper: (SensorData data, _) => data.humidity,
              name: 'Air Humidity (%)',
              color: Colors.blue,
            ),
            LineSeries<SensorData, DateTime>(
              dataSource: controller.sensorData,
              xValueMapper: (SensorData data, _) => data.time,
              yValueMapper: (SensorData data, _) => data.temperature,
              name: 'Air Temp (°C)',
              color: Colors.red,
            ),
            LineSeries<SensorData, DateTime>(
              dataSource: controller.sensorData,
              xValueMapper: (SensorData data, _) => data.time,
              yValueMapper: (SensorData data, _) => data.soilHumidity,
              name: 'Soil Humidity (%)',
              color: Colors.green,
            ),
            LineSeries<SensorData, DateTime>(
              dataSource: controller.sensorData,
              xValueMapper: (SensorData data, _) => data.time,
              yValueMapper: (SensorData data, _) => data.soilTemperature,
              name: 'Soil Temp (°C)',
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
