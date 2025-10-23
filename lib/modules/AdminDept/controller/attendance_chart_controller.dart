import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../Model/attendance_chart_model.dart';
import '../Provider/attendance_chart_provider.dart';

class AttendanceChartController extends GetxController {
  final AttendanceChartProvider _provider = AttendanceChartProvider();

  final attendanceData = <AttendanceChartModel>[].obs;
  final chartBarGroups = <BarChartGroupData>[].obs;

  var isLoading = false.obs;
  var isPieChart = false.obs;

  final List<Color> colorList = [
    Colors.blue.shade700,
    Colors.green.shade700,
    Colors.purple.shade700,
  ];

  final List<Map<String, double>> defaultChartData = [
    {'Check-in': 0},
    {'Late': 0},
    {'Other': 0},
  ];

  @override
  void onInit() {
    super.onInit();
    fetchAttendanceData();
    ever(attendanceData, (_) => transformDataForChart());
  }

  Future<void> fetchAttendanceData() async {
    try {
      isLoading.value = true;
      final rawData = await _provider.getAttendanceDataChart();
      attendanceData.value = rawData;
    } catch (e) {
      attendanceData.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void transformDataForChart() {
    if (attendanceData.isEmpty) {
      chartBarGroups.clear();
      return;
    }

    final List<BarChartGroupData> groups = [];

    for (int i = 0; i < attendanceData.length; i++) {
      final record = attendanceData[i];
      final color = colorList[i % colorList.length];
      groups.add(_makeGroupData(i, record.count.toDouble(), color));
    }

    chartBarGroups.value = groups;
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color.withOpacity(0.9),
          width: 22,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    final index = value.toInt();
    final label =
        (index >= 0 && index < attendanceData.length)
            ? attendanceData[index].category
            : '';

    return SideTitleWidget(
      fitInside: const SideTitleFitInsideData(
        enabled: false,
        axisPosition: 0.0,
        parentAxisSize: 50.0,
        distanceFromEdge: 2,
      ),
      meta: meta,
      space: 1,
      child: Text(label, style: style),
    );
  }

  Map<String, double> get pieChartDataMap {
    return {
      for (var item in attendanceData) item.category: item.count.toDouble(),
    };
  }

  void toggleChartType() {
    isPieChart.value = !isPieChart.value;
  }
}
