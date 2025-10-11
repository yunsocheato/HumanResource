import 'package:get/get.dart';
import 'package:flutter/material.dart';
class AppDrawerController extends GetxController with SingleGetTickerProviderMixin  {
  var selectedIndex = 0.obs;
  var loadingTile = ''.obs;
  var expandedTile = ''.obs;

  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> blurAnimation;

  final Color Selectedcolors = Colors.blue.shade900;
  final Color Unselectedcolors = Colors.white;

  get expandedStates => <String, bool>{}.obs;

  bool isExpanded1(String title) {
    return expandedTile.value == title;
  }

  isExpanded(String title) {
    return expandedStates[title] ?? false;
  }

  void toggleExpand(String title) {
    final current = expandedStates[title] ?? false;
    expandedStates[title] = !current;
  }

  void toggleTile1(String title) {
    if (expandedTile.value == title) {
      expandedTile.value = ''; // Collapse if same tile tapped again
    } else {
      expandedTile.value = title; // Expand new tile
    }
  }

  void setloading(String title) {
    loadingTile.value = title;
  }

  void clearLoading() {
    loadingTile.value = '';
  }

  void setSelected(int index) {
    selectedIndex.value = index;

  }

  Color iconColor(int index){
    return selectedIndex.value == index ? Selectedcolors : Unselectedcolors;
  }

  @override
  void onInit() {
    super.onInit();

    controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    controller2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    blurAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: controller1, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}
