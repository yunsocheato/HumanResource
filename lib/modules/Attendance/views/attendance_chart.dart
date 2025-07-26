import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/attendance_chart_controller.dart';
import '../models/attendance_chart_model.dart';

class AttendacneChart extends GetView<ChartController> {
  const AttendacneChart({super.key});

  @override
  Widget build(BuildContext context) {
    return _ResponsiveWidget();
  }

  Widget _ResponsiveWidget() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildBarChartObxColumn() : _buildBarChartObxRow();
  }
  Widget _buildBarChartObxColumn() {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Attendance By Department",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

            // Chart Body
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 300,
                child: _buildBarChartColumn(),
              ),
            ),
        ]
        ),
      ),
    );
  }

  Widget _buildBarChartColumn() {
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
        title: ChartTitle(
          text: 'Attendance Count by Department',
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: Legend(isVisible: true),
        primaryXAxis: CategoryAxis(labelRotation: 0),
        primaryYAxis: NumericAxis(),
        series: <CartesianSeries<Chartmodel, String>>[
          ColumnSeries<Chartmodel, String>(
            name: 'Bar',
            dataSource: chartData,
            xValueMapper: (Chartmodel data, _) => data.category,
            yValueMapper: (Chartmodel data, _) => data.value,
            pointColorMapper: (Chartmodel data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
          LineSeries<Chartmodel, String>(
            name: 'Line',
            dataSource: chartData,
            xValueMapper: (Chartmodel data, _) => data.category,
            yValueMapper: (Chartmodel data, _) => data.value,
            pointColorMapper: (Chartmodel data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
        ],
      );
    });
  }

  Widget _buildBarChartObxRow() {
    final context = Get.context!;
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Attendance By Department",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 300,
              child: _buildBarChartRow(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChartRow() {
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
        title: ChartTitle(
          text: 'Attendance Count by Department',
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: CategoryAxis(labelRotation: 0),
        primaryYAxis: NumericAxis(),
        series: <CartesianSeries<Chartmodel, String>>[
          ColumnSeries<Chartmodel, String>(
            name: 'Column',
            dataSource: chartData,
            xValueMapper: (Chartmodel data, _) => data.category,
            yValueMapper: (Chartmodel data, _) => data.value,
            pointColorMapper: (Chartmodel data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
          LineSeries<Chartmodel, String>(
            name: 'Line',
            dataSource: chartData,
            xValueMapper: (Chartmodel data, _) => data.category,
            yValueMapper: (Chartmodel data, _) => data.value,
            pointColorMapper: (Chartmodel data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
        ],
      );
    });
  }
}
