import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../controllers/attendance_chart_controller.dart';
import '../models/attendance_chart_model.dart';

class AttendanceChart extends GetView<ChartController> {
  const AttendanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Get.size.width;

    final isMobile = Get.width < 900;
    final isLaptop = Get.width >= 1440;
    double titleFontSize;

    if (isMobile) {
      titleFontSize = 14;
    } else if (isLaptop) {
      titleFontSize = 18;
    } else {
      titleFontSize = 16;
    }

    final HoverMouseController hoverController = Get.put(
      HoverMouseController(),
    );

    return MouseHover(
      keyId: 1,
      controller: hoverController,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "GRAPH OF ATTENDANCE",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
            ),
            Expanded(child: _buildChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    final chartCtrl = Get.find<ChartController>();
    return Obx(() {
      final chartData = List.generate(chartCtrl.departments.length, (i) {
        return Chartmodel(
          category: chartCtrl.departments[i],
          value: chartCtrl.counts[i],
          color: chartCtrl.colors[i],
        );
      });

      return SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        primaryXAxis: CategoryAxis(labelRotation: 0),
        primaryYAxis: NumericAxis(),
        series: <CartesianSeries<Chartmodel, String>>[
          ColumnSeries<Chartmodel, String>(
            name: 'Department',
            dataSource: chartData,
            xValueMapper: (Chartmodel data, _) => data.category,
            yValueMapper: (Chartmodel data, _) => data.value,
            pointColorMapper: (Chartmodel data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          LineSeries<Chartmodel, String>(
            name: 'Trend',
            dataSource: chartData,
            xValueMapper: (Chartmodel data, _) => data.category,
            yValueMapper: (Chartmodel data, _) => data.value,
            pointColorMapper: (Chartmodel data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      );
    });
  }
}
