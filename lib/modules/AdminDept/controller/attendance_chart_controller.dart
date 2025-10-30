import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Model/attendance_chart_model.dart';
import '../Provider/attendance_chart_provider.dart';

class AttendanceChartController extends GetxController {
  final AttendanceChartProvider _provider = AttendanceChartProvider();

  final attendanceChartData = <AttendanceChartModel>[].obs;
  final currentUser = Rxn<User>();
  final RxList<dynamic> chartBarGroups = <dynamic>[].obs;
  var selectedRange = '1day'.obs;

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
  final List<String> ranges = [
    '1day',
    '3days',
    '1week',
    '2weeks',
    '1month',
    '2months',
    '3months',
    '6months',
    '1year',
    '2years',
  ];

  @override
  void onInit() {
    super.onInit();
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        fetchTodayChart();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        attendanceChartData.clear();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      fetchTodayChart();
    }

    ever(attendanceChartData, (_) => transformDataForChart());
  }

  Future<void> fetchAttendanceAllData() async {
    try {
      isLoading.value = true;
      final rawData = await _provider.getAttendanceDataChart();
      attendanceChartData.value = rawData;
    } catch (e) {
      attendanceChartData.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchChartbyDate() async {
    try {
      isLoading.value = true;
      final data = await _provider.getAttendanceChartByDate(
        range: selectedRange.value,
      );
      const categories = ['Check-in', 'Late', 'Other'];
      attendanceChartData.value =
          categories.map((cat) {
            final found = data.firstWhere(
              (d) => d.category == cat,
              orElse: () => AttendanceChartModel(category: cat, count: 0),
            );
            return found;
          }).toList();
    } catch (e) {
      attendanceChartData.value = [
        AttendanceChartModel(category: 'Check-in', count: 0),
        AttendanceChartModel(category: 'Late', count: 0),
        AttendanceChartModel(category: 'Other', count: 0),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTodayChart() async {
    try {
      isLoading.value = true;
      final data = await _provider.getAttendanceChartToday();

      const defaultCategories = ['Check-in', 'Late', 'Other'];

      final allCategories = {
        ...defaultCategories,
        ...data.map((e) => e.category),
      };

      final mergedData =
          allCategories.map((category) {
            final found = data.firstWhere(
              (d) => d.category == category,
              orElse: () => AttendanceChartModel(category: category, count: 0),
            );
            return found;
          }).toList();

      attendanceChartData.value = mergedData;
    } catch (e) {
      print('Error fetching today chart: $e');
      attendanceChartData.value = [
        AttendanceChartModel(category: 'Check-in', count: 0),
        AttendanceChartModel(category: 'Late', count: 0),
        AttendanceChartModel(category: 'Other', count: 0),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  void transformDataForChart() {
    if (attendanceChartData.isEmpty) {
      chartBarGroups.clear();
      return;
    }

    final List<BarChartGroupData> groups = [];
    for (int i = 0; i < attendanceChartData.length; i++) {
      final record = attendanceChartData[i];
      final color = colorList[i % colorList.length];
      groups.add(_makeBarChartGroupData(i, record.count.toDouble(), color));
    }
    chartBarGroups.value = groups;
  }

  BarChartGroupData _makeBarChartGroupData(int x, double y, Color color) {
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

  void setRange(String range) {
    selectedRange.value = range;
    fetchChartbyDate();
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    final index = value.toInt();
    final label =
        (index >= 0 && index < attendanceChartData.length)
            ? attendanceChartData[index].category
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
      for (var item in attendanceChartData)
        item.category: item.count.toDouble(),
    };
  }

  void toggleChartType() {
    isPieChart.value = !isPieChart.value;
  }
}
