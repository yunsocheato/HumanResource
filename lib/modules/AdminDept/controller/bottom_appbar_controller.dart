import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/view/overview_screen.dart';

class BottomAppBarController1 extends GetxController {
  var isSelectedindex = 0.obs;
  final Color Selectedcolors = Colors.blue.shade900;
  final Color Unselectedcolors = Colors.black54;
  final tabCount = 4;
  final double indicatorWidth = 50;
  final context = Get.context;

  void SelectedIndex(int index) {
    isSelectedindex.value = index;

    switch (index) {
      case 0:
        Get.toNamed(OverViewScreen.routeName);
        break;
      case 1:
        Get.toNamed(OverViewScreen.routeName);
        break;
      case 2:
        Get.toNamed(OverViewScreen.routeName);
        break;
      case 3:
        Get.toNamed(OverViewScreen.routeName);
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
