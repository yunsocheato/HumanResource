import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Drawer/widgets/Method_drawer_policy_button.dart';

class ScheduleController extends GetxController{
  final ScrollController horizontalScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();
  var showHeader = false.obs;
  var  showlogincard1 = true.obs;
  var showCards = true.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 500), () {
        showHeader = true.obs;

    });
  }

  @override
  void dispose() {
    horizontalScrollController.dispose();
    verticalScrollController.dispose();
    super.dispose();
  }

  void refreshdata ()  async {
    await MethodButton12();
    update();
  }

  void toogleShowlogincard1 () {
    showlogincard1.value = !showlogincard1.value;
  }


}