import 'package:get/get.dart';

class HoverMouseController extends GetxController{
  var hoveringMap = <int, bool>{}.obs;
  bool isHovering(int keyId) {
    return hoveringMap[keyId] ?? false;
  }

  void setHovering(int keyId, bool value) {
    hoveringMap[keyId] = value;
  }
}