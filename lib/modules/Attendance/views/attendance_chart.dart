import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../controllers/attendance_chart_controller.dart';
import '../models/attendance_chart_model.dart';

class AttendanceChart extends GetView<ChartController> {
  const AttendanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;
    final isLargeDesktop = width >= 2560;
    final isLaptop = width >= 1440;

    double chartHeight;
    double titleFontSize;
    double cardWidth;

    if (isMobile) {
      chartHeight = 260;
      titleFontSize = 14;
      cardWidth = double.infinity;
    } else if (isTablet) {
      chartHeight = 270;
      titleFontSize = 16;
      cardWidth = width * 0.2;
    } else if (isLaptop) {
      chartHeight = 280;
      titleFontSize = 14;
      cardWidth = width * 0.2;
    }
    else if (isDesktop) {
      chartHeight = 290;
      titleFontSize = 20;
      cardWidth = width * 0.4;
    } else if (isLargeDesktop) {
      chartHeight = 310;
      titleFontSize = 22;
      cardWidth = width * 1.0;
    }
    else {
      chartHeight = 350;
      titleFontSize = 26;
      cardWidth = width * 0.9;
    }
    final HoverMouseController controller = Get.put(HoverMouseController());
    return MouseHover(
      keyId: 1,
      controller: controller,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(8),
        child: SizedBox(
          width: cardWidth,
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
              SizedBox(
                height: chartHeight,
                child: _buildChart(),
              ),
            ],
          ),
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
