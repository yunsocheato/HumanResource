import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomAppBarController extends GetxController {
  var isSelectedindex = 0.obs;
  final Color Selectedcolors = Colors.blue.shade900;
  final Color Unselectedcolors = Colors.black54;
  final tabCount = 4;
  var bottomBarPosition = 0.0.obs;

  final double indicatorWidth = 50;
  final context = Get.context;

  void SelectedIndex(int index) {
    isSelectedindex.value = index;

    switch (index) {
      case 0:
        Get.offAllNamed('/overview');
        break;
      case 1:
        Get.offAllNamed('/attendance_user');
        break;
      case 2:
        Get.offAllNamed('/report');
        break;
      case 3:
        Get.offAllNamed('/settings');
        break;
    }
  }

  Color iconColor(int index) {
    return isSelectedindex.value == index ? Selectedcolors : Unselectedcolors;
  }

  double indicatorAlignmentX(int index) {
    return (2 / (tabCount - 1)) * index - 1;
  }
}
