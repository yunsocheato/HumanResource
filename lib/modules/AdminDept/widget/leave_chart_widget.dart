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
            return Padding(
              padding: EdgeInsets.all(cardPadding),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.blue,
                      spots: controller.spots,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
