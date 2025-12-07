import 'package:get/get.dart';

class SettingController extends GetxController {
  final isDarkMode = true.obs;
  final List<String> items = ['GENERAL', 'APPEARANCE', 'NOTIFICATION'].obs;
  final selectedIndex = 0.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
  }
}
