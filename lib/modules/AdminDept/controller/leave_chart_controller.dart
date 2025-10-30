import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../Model/leave_chart_model.dart';
import '../Provider/leave_chart_provider.dart';

class LeaveChartController extends GetxController {
  final LeaveChartProvider _provider = LeaveChartProvider();

  final spots = <FlSpot>[].obs;

  final selectedYear = DateTime.now().year.obs;
  final selectedMonth = 'All'.obs;

  final availableYears = List.generate(5, (i) => DateTime.now().year - i);
  final availableMonths = [
    'All',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  void setYear(int year) {
    selectedYear.value = year;
    loadMonthlyChartData();
  }

  void setMonth(String month) {
    selectedMonth.value = month;
    loadMonthlyChartData();
  }

  @override
  void onInit() {
    super.onInit();
    loadMonthlyChartData();
  }

  @override
  void onClose() {
    super.onClose();
    spots.clear();
  }

  final List<String> MonthName = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String getMonthLabel(double value) {
    int index = value.toInt();
    if (index < 0 || index > 11) return '';
    return MonthName[index];
  }

  Future<void> loadMonthlyChartData() async {
    final List<LeaveChartModel> requests =
        await _provider.getAllPendingLeaveRequests();

    if (requests.isEmpty) {
      spots.value = [];
      return;
    }
    final Map<int, int> monthCounts = {for (var i = 0; i < 12; i++) i: 0};
    for (var leave in requests) {
      final leaveYear = leave.fromDate.year;
      final leaveMonth = leave.fromDate.month;

      if (leaveYear == selectedYear.value) {
        if (selectedMonth.value == 'All' ||
            leaveMonth == availableMonths.indexOf(selectedMonth.value)) {
          int monthIndex = leaveMonth - 1;
          monthCounts[monthIndex] = (monthCounts[monthIndex] ?? 0) + 1;
        }
      }
    }
    spots.value =
        monthCounts.entries
            .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
            .toList();
  }
}
