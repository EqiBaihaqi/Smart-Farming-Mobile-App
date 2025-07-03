import 'package:flutter/material.dart';
import 'package:smart_farm/page/chart_page/chart_date_selector.dart';
import 'package:smart_farm/page/chart_page/chart_metric_dropdown.dart';
import 'package:smart_farm/page/chart_page/chart_sensor_dropdown.dart';

class ChartControlPanel extends StatefulWidget {
  const ChartControlPanel({super.key});

  @override
  State<ChartControlPanel> createState() => _ChartControlPanelState();
}

class _ChartControlPanelState extends State<ChartControlPanel> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdowns
            Row(
              children: [
                Flexible(child: ChartSensorDropdown()),
                const SizedBox(width: 16),
                Flexible(child: ChartMetricDropdown()),
              ],
            ),
            const SizedBox(height: 12),
            // Date Picker Button
            ChartDateSelector(),
          ],
        ),
      ),
    );
  }
}
