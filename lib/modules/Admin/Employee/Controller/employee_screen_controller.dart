
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Drawer/widgets/Method_drawer_policy_button.dart';

class EmployeeScreenController extends GetxController {
  var  showlogincard1 = true.obs;
  var showCards = true.obs;
  var recentDataLoaded = false.obs;
  var isLoading = true.obs;

  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();

  @override
  void onInit() {
    loaddata();
    super.onInit();
  }


  void toogleShowlogincard1 () {
    showlogincard1.value = !showlogincard1.value;
  }

  void refreshdata ()  async {
    await MethodButton6();
    update();
  }

  void loaddata() async {
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }

}