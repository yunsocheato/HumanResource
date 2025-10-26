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
        final double maxWidth = constraints.maxWidth;

        final bool isMobile = maxWidth < 900;
        final bool isLaptop = maxWidth >= 900 && maxWidth < 1440;
        final bool isDesktop = maxWidth >= 1440;

        double chartHeight =
            isMobile
                ? 200
                : isLaptop
                ? 150
                : isDesktop
                ? 400
                : 250;

        double cardPadding =
            isMobile
                ? 10
                : isLaptop
                ? 15
                : isDesktop
                ? 20
                : 10;
        return Container(
          height: chartHeight,
          width: double.infinity,
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Obx(() {
            if (controller.spots.isEmpty) {
              return const Center(
                child: Text(
                  "No leave data for this period",
                  style: TextStyle(color: Colors.black54),
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
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 30,
                      interval: 1,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
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
                      show: false,
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
          }),
        );
      },
    );
  }
}
