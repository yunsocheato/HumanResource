import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../controllers/loginscreen_animation_controller.dart';
import '../widgets/login_decor_widget.dart';

class LoginScreen extends GetView<LoginScreenWidgetDecor> {
  static const String routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginScreenWidgetDecor());
    Get.put<LoadingUiController>( LoadingUiController());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child:  Padding(
              padding: const EdgeInsets.only(top: 10),
              child: LoginCard(),
            ),
          ),
          Positioned(
            top: 50,
            left: 725,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              ],
            ),
          ),
          _buildAnimatedBubble(controller, 10, 30),
          _buildAnimatedBubble(controller, 100, 300),
          _buildAnimatedBubble(controller, 200, 50),
          _buildAnimatedBubble(controller, 100, 60),
          _buildAnimatedBubble(controller, 100, 20, fromBottom: true),
          _buildAnimatedBubble(controller, 300, 10, fromBottom: true),
          _buildAnimatedBubble(controller, 250, 60, fromBottom: true),
          _buildAnimatedBubble(controller, 100, 60, fromBottom: true),
          _buildAnimatedBubble(controller, 100, 20, fromBottom: true),
          _buildAnimatedBubble(controller, 300, 10, fromBottom: true),
          if(Get.isRegistered<LoadingUiController>())
          LoadingScreen()
        ],
      ),
    );
  }
  Widget _buildAnimatedBubble(
  LoginScreenWidgetDecor controller ,
      double top, double left, {bool fromBottom = false}) {
    return Positioned(
      top: fromBottom ? null : top,
      bottom: fromBottom ? top : null,
      left: left,
      child: AnimatedBuilder(
        animation: controller.BubbleSizeAnimationController,
        builder: (context, child) {
          return Container(
            width: controller.BubbleSizeAnimationController.value,
            height: controller.BubbleSizeAnimationController.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
          );
        },
      ),
    );
  }

}
