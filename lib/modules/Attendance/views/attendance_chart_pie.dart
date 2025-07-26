import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/attendance_chart_pie_controller.dart';
import '../models/attendance_chart_pie_model.dart';

class AttendacneChartPie extends GetView<ChartPieController> {
  const AttendacneChartPie({super.key});

  @override
  Widget build(BuildContext context) {
    return _ResponsiveWidget();
  }

  Widget _ResponsiveWidget() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildPieChartColoumObx() : _buildPieChartRowObx();
  }

  Widget _buildPieChartRowObx() {
    final context = Get.context!;
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green.shade900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Attendance Leave",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildPieChartRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartRow() {
    final pieController = Get.find<ChartPieController>();

    return Obx(
          () =>
          SfCircularChart(
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
            ),
            series: <CircularSeries>[
              PieSeries<ShowData, String>(
                dataSource: pieController.Chartpie.toList(),
                xValueMapper: (ShowData data, _) => data.category,
                yValueMapper: (ShowData data, _) => data.value,
                dataLabelMapper:
                    (ShowData data, _) =>
                '${data.category}: ${data.value.toStringAsFixed(0)}',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  textStyle: TextStyle(fontSize: 14),
                ),
                pointColorMapper: (ShowData data, _) => data.color,
                enableTooltip: true,
                legendIconType: LegendIconType.circle,
                radius: '80%',
                explode: true,
                explodeAll: true,
              ),
            ],
          ),
    );
  }

  Widget _buildPieChartColoumObx() {
    final context = Get.context!;
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width * 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 50,
              decoration:  BoxDecoration(
                color: Colors.green.shade900,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Daily Attendance",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildPieChartColoum(),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartColoum() {
    final pieController = Get.find<ChartPieController>();

    return Obx(
          () =>
          SfCircularChart(
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
            ),
            series: <CircularSeries>[
              PieSeries<ShowData, String>(
                dataSource: pieController.Chartpie.toList(),
                xValueMapper: (ShowData data, _) => data.category,
                yValueMapper: (ShowData data, _) => data.value,
                dataLabelMapper:
                    (ShowData data, _) =>
                '${data.category}: ${data.value.toStringAsFixed(0)}',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  textStyle: TextStyle(fontSize: 14),
                ),
                pointColorMapper: (ShowData data, _) => data.color,
                enableTooltip: true,
                legendIconType: LegendIconType.circle,
                radius: '70%',
                explode: true,
                explodeAll: true,
              ),
            ],
          ),
    );
  }
}