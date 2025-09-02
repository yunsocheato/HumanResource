import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Drawer/widgets/Method_drawer_policy_button.dart';

class DepartmentScreenController extends GetxController {
  var showCards = true.obs;
  var recentDataLoaded = false.obs;
  var isLoading = true.obs;

  var  showlogincard1 = true.obs;

  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();

  void toogleShowlogincard1 () {
    showlogincard1.value = !showlogincard1.value;
  }

  void refreshdata() async {
    await MethodButton4();
    isLoading.value = false;
  }

  @override
  void onInit() {
    loaddata();
    super.onInit();
  }

  @override
  void onClose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    super.onClose();
  }


  void loaddata() async {
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }
}