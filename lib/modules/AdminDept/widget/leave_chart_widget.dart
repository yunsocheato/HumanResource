import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../controller/leave_chart_controller.dart';

class LeaveChartWidget extends GetView<LeaveChartController> {
  const LeaveChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final bool isMobile = width < 600;
        final bool isTablet = width >= 600 && width < 900;
        final bool isLaptop = width >= 900 && width < 1200;
        final bool isDesktop = width >= 1200 && width < 1600;
        final bool isLargeDesktop = width >= 1600;

        double chartHeight;
        if (isMobile) {
          chartHeight = width * 0.35;
        } else if (isTablet) {
          chartHeight = width * 0.25;
        } else if (isLaptop) {
          chartHeight = width * 0.2;
        } else if (isDesktop) {
          chartHeight = width * 0.18;
        } else {
          chartHeight = width * 0.15;
        }

        return Obx(() {
          if (controller.spots.isEmpty) {
            return Center(
              child: Text(
                "No leave data for this period",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          double maxX =
              controller.selectedMonth.value == 'All'
                  ? 11
                  : controller.spots.value.first.x;
          double maxY = controller.spots.value
              .map((e) => e.y)
              .fold(0, (prev, y) => y > prev ? y : prev);
          maxY = maxY < 5 ? 5 : maxY;

          return LineChart(
            LineChartData(
              minX:
                  controller.selectedMonth.value == 'All'
                      ? 0
                      : controller.spots.value.first.x,
              maxX: maxX,
              minY: 0,
              maxY: maxY,
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, _) {
                      final month = controller.getMonthLabel(value);
                      return Text(
                        month,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                  ),
                  spots: controller.spots,
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.lightBlueAccent.withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
