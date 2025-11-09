import 'package:get/get.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';

class LoginCardController extends GetxController
    with SingleGetTickerProviderMixin {
  final loadingUi = Get.put<LoadingUiController>(LoadingUiController());

  RxBool hide = true.obs;
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;
  RxBool showLoginCard = false.obs;

  final error = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 500), () {
      showLoginCard.value = true;
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
