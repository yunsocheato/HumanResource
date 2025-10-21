import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../Utils/Loadingui/ErrorScreen/Controller/ErrorMessage.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../../../../Utils/Network/Method/method_internet_connection.dart';
import '../../Dashboard/views/dashboard_screen.dart';
import '../services/login_service.dart';

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
