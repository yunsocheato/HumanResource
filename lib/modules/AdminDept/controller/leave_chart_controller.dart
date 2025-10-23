import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class LeaveChartController extends GetxController {
  var spots = <FlSpot>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadChartData();
  }

  void loadChartData() {
    spots.value = [
      FlSpot(0, 20),
      FlSpot(1, 40),
      FlSpot(2, 35),
      FlSpot(3, 60),
      FlSpot(4, 70),
      FlSpot(5, 65),
      FlSpot(6, 80),
    ];
  }

  void updateData(List<FlSpot> newSpots) {
    spots.value = newSpots;
  }
}
