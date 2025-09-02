import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Dashboard/views/dashboard_screen.dart';

class BottomAppBarController extends GetxController{

  var isSelectedindex = 0.obs;
  final Color Selectedcolors = Colors.blue.shade900;
  final Color Unselectedcolors = Colors.black54;

  void SelectedIndex(int index){

    isSelectedindex.value = index;
    
    switch(index){
      case 0:
        Get.toNamed(DashboardScreen.routeName);
        break;
      case 1:
        Get.toNamed(DashboardScreen.routeName);
        break;
      case 2:
        Get.toNamed(DashboardScreen.routeName);
        break;
      case 3:
        Get.toNamed(DashboardScreen.routeName);
        break;
    }
  }

  Color iconColor(int index){
    return isSelectedindex.value == index ? Selectedcolors : Unselectedcolors;
  }
}