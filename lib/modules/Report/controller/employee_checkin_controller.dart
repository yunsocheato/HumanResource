import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../API/employee_checkin_sql.dart';
import '../Model/employee_checkin_model.dart';

class EmployeeCheckinController extends GetxController{
  final user = <EmployeeCheckinModel>[].obs;
  final employeeCheckinSQL = empoloyeecheckINSQL();
  StreamSubscription<List<EmployeeCheckinModel>>? _subscription;

  final isLoading = false.obs;
  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();
  final showlogincard1 = true.obs;
  final showCards = true.obs;
  final recentDataLoaded = false.obs;
  final refreshdata = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindStream();
  }


  void _bindStream() {
    isLoading.value = true;
    _subscription = employeeCheckinSQL.employeecheckin().listen(
          (event) {
        user.assignAll(event);
        isLoading.value = false;
      },
      onError: (error) {
        isLoading.value = false;
        Get.snackbar('Error', error.toString());
      },
    );
  }

  @override
  void onClose() {
    _subscription?.cancel();
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    super.onClose();
  }}

class EmployeeCheckinCount extends GetxController{
  final _employeeCheckinCountModel = <EmployeeCheckinCountModel>[].obs;
  final _employeeCheckinSQL = empoloyeecheckINSQL();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindStream();
  }

  void _bindStream() {
    isLoading.value = true;
    _employeeCheckinSQL.employeecheckinCount().listen((event) {
      _employeeCheckinCountModel.assignAll(event);
      isLoading.value = false;
    }, onError: (error) {
      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    }
    );
  }

  void refreshdata(){
    _bindStream();
  }
}