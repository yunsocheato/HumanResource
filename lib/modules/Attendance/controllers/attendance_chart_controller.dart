import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartController extends GetxController {
  var selectedValue =  ''.obs;
  RxList<double> counts = [5.0, 3.0, 1.0, 1.0, 1.0].obs;
  List <Color> colors = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.purple];
  List<String>departments = ['HR', 'IT', 'Finance', 'Sales', 'Admin'];

  void updateHover(int index, double value) {
    counts[index] = value;
  }

}

