import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../API/employee_report_sql.dart';
import '../Model/employee_checkin_model.dart';


class EmployeeReportController extends GetxController {
  final RxList<EmployeeCheckinModel> data = <EmployeeCheckinModel>[].obs;
  final empoloyeecheckINSQL employeeCheckinSQL = empoloyeecheckINSQL();

  int currentPage = 0;
  int pageSize = 100;
  final isLoading = false.obs;

  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();

  final showlogincard1 = true.obs;
  final showlogincard2 = true.obs;
  final showlogincard3 = true.obs;
  final showlogincard4 = true.obs;

  final isExporting1 = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData(page: currentPage, pageSize: pageSize);
  }

  @override
  void onClose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    super.onClose();
  }

  Future<void> fetchData({required int page, required int pageSize}) async {
    try {
      isLoading.value = true;

      final newData = await employeeCheckinSQL.employeecheckin(
        page: page + 1,
        pageSize: pageSize,
      );

      data.assignAll(newData.map((e) => EmployeeCheckinModel.fromJson(e)));

      currentPage = page;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void refreshData() => fetchData(page: currentPage, pageSize: pageSize);

  void updatePagination(int newPageSize, int newPage) {
    pageSize = newPageSize;
    currentPage = newPage;
    fetchData(page: newPage, pageSize: newPageSize);
  }
}
