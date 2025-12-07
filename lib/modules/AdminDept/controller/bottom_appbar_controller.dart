import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BottomAppBarController1 extends GetxController {
  var isSelectedindex = 0.obs;
  final Color Selectedcolors = Colors.blue.shade900;
  final Color Unselectedcolors = Colors.black54;
  final tabCount = 4;
  final double indicatorWidth = 50;
  late ScrollController scrollController;
  var bottomBarPosition = 0.0.obs;
  static const double barHeight = 75.0 + 15.0;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (bottomBarPosition.value != barHeight) {
          bottomBarPosition.value = barHeight;
        }
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (bottomBarPosition.value != 0.0) {
          bottomBarPosition.value = 0.0;
        }
      }
    });
  }

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
