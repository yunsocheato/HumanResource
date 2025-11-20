import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_chart_controller.dart';
import 'package:pie_chart_sz/ValueSettings.dart';
import 'package:pie_chart_sz/pie_chart_sz.dart';

import '../Model/attendance_chart_model.dart';

class AttendanceChartWidget extends GetView<AttendanceChartController> {
  const AttendanceChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double chartSize =
            width < 600
                ? 250
                : (width < 1024 ? 280 : (width < 1440 ? 420 : 500));

        return Center(
          child: Obx(() {
            if (controller.isLoading.value) {
              return SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                  width: chartSize,
                  height: chartSize,
                ),
              );
            }

            final List<String> categories = ['Check-in', 'Late', 'Other'];

            final values =
                categories.map((category) {
                  final record = controller.attendanceChartData.firstWhere(
                    (e) => e.category == category,
                    orElse:
                        () =>
                            AttendanceChartModel(category: category, count: 0),
                  );
                  return record.count.toDouble() == 0
                      ? 0.000
                      : record.count.toDouble();
                }).toList();

            final total = values.fold<double>(0, (sum, v) => sum + v);

            if (total == 0) {
              return SizedBox(
                width: chartSize,
                height: chartSize,
                child: Center(
                  child: Text(
                    "No attendance data today",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width < 600 ? 16 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              );
            }

            List<Color> colors =
                controller.colorList.take(values.length).toList();

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.7),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: chartSize,
                  height: chartSize,
                  child: PieChartSz(
                    colors: colors,
                    values: values,
                    gapSize: 0.2,
                    centerText: "ANALYZE",
                    centerTextStyle: TextStyle(
                      fontSize: width < 600 ? 16 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    valueSettings: Valuesettings(
                      showValues: true,
                      ValueTextStyle: TextStyle(
                        fontSize: width < 600 ? 16 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
