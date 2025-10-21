import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class LoginScreenWidgetDecor extends GetxController with GetTickerProviderStateMixin {
  late AnimationController AntimationController;
  late Animation<double> BubbleSizeAnimationController;

  @override
  void onInit(){
    AntimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    BubbleSizeAnimationController = Tween<double>(begin: 80, end: 120).animate(
      CurvedAnimation(parent: AntimationController, curve: Curves.bounceOut),
    );
  }

  @override
  void onClose () {
    AntimationController.dispose();
    super.onClose();
  }

}