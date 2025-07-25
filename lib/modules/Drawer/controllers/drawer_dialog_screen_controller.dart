import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/drawer_dialog_screen.dart';

class DialogScreenController extends GetxController{
  final isLoading = false.obs;
  final isExpanded = false.obs;

  void toggleLoading() => isLoading.value = true ;
  void toggleExpanded() => isExpanded.toggle();
  void hideLoading() => isLoading.value = false;

  void CloseDialog(){
    if(Get.isDialogOpen ?? false) { Get.back();}
  }
  void ShowcustomDialog( Widget content , {bool isfullscreen = false }) {
    Get.dialog(DialogScreen(content: content, isfullscreen: isfullscreen),
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        transitionCurve : Curves.easeInBack
    );
  }
}