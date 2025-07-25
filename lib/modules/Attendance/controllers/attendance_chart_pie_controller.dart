import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/attendance_chart_pie_model.dart';

class ChartPieController extends GetxController {
  final Chartpie = <ShowData>[
    ShowData(category: 'Absent', value: 5.0, color: Colors.blue),
    ShowData(category: 'Leave', value: 3.0, color: Colors.red),
    ShowData(category: 'Late', value: 1.0, color: Colors.green),
    ShowData(category: 'CheckIN', value: 1.0, color: Colors.yellow),
  ].obs;

  void updateCategoryChartPie(String category, double value, Color color) {
    final index = Chartpie.indexWhere((element) => element.category == category);
    if (index != -1) {
      Chartpie[index] = ShowData(category: category, value: value, color: color);
    }
  }
}
