import 'package:get/get.dart';

class AppDrawerController extends GetxController {
  var selectedIndex = 0.obs;
  var loadingTile = ''.obs;
  var expandedTile = ''.obs;

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
}
