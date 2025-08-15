import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateController extends GetxController{
  final buttonUpdate = true.obs;
  final isLoading = false.obs;
  final RxString githubCode = ''.obs ;

  var Username = 'yunsocheato'.obs;
  var localgithub = 'https://github.com/yunsocheato/HumanResource.git'.obs;

  @override
  void onInit() {
    super.onInit();
    githubCode.value = localgithub.value;
  }

  Future<void> GetUpdateFromGithubCode() async{
    isLoading.value = true;
    buttonUpdate.value = false;
    try {
      final response = await http.get(Uri.parse(githubCode.value));
      if (response.statusCode == 200) {
        Get.snackbar(
          'Update',
          'Update Successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white.withOpacity(0.3),
          colorText: Colors.black,
        );
        isLoading.value = false;
        Get.close(0);
      }else{
        Get.snackbar(
          'Update',
          'Update Failed',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white.withOpacity(0.3),
          colorText: Colors.black,
        );
        isLoading.value = false;
      }
    }catch(e){
      Get.snackbar(
        'Update',
        'Update Got Problem',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withOpacity(0.3),
        colorText: Colors.black,
      );
      isLoading.value = false;
    }finally{
      isLoading.value = false;
      buttonUpdate.value = true;
      update();
    }
  }
}