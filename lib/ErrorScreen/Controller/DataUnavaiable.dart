import 'package:get/get.dart';

class DataUnavailable extends GetxController {
  var imageNotFound = false.obs;
  final String imageUrl = 'assets/images/unavailabledata.png';

  void showImage() {
    imageNotFound.value = true;
  }

  Future<void> refreshData() async {
    imageNotFound.value = true;
    await Future.delayed(const Duration(seconds: 2));
    imageNotFound.value = true;
  }
}
