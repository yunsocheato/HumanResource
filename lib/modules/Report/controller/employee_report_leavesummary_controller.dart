import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../API/employee_report_sql3.dart';
import '../Model/employee_leave_summary_model.dart';

class leavesummarycontroller extends GetxController{
  final RxList<EmployeeLeaveSummaryModel> data = <EmployeeLeaveSummaryModel>[].obs;
  final EmployeeReportSql3 employeeleavesummarySQL3 = EmployeeReportSql3();

  int currentPage = 1;
  int pageSize = 100;

  int from = 0;
  int to = 100;
  
  bool hasMoreData = true;

  final isLoading = false.obs;
  final isExporting1 = false.obs;

  Rx<DateTime?> startDate = DateTime.now().obs;
  Rx<DateTime?> endDate = DateTime.now().obs;

  final isPressed1 = false.obs;
  final isPressed2 = false.obs;
  final showlogincard1 = true.obs;
  final showlogincard2 = true.obs;
  final showlogincard3 = true.obs;
  final showlogincard4 = true.obs;

  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    fetchData(page: currentPage, pageSize: pageSize);

    verticalScrollController.addListener(() {
      if (verticalScrollController.position.pixels >=
          verticalScrollController.position.maxScrollExtent &&
          !isLoading.value &&
          hasMoreData) {
        loadMore();
      }
    });
  }

  @override
  void onClose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    super.onClose();
  }

  Future<void> fetchData({required int page, required int pageSize}) async {
    if (startDate.value == null || endDate.value == null) return;

    try {
      isLoading.value = true;

      final newData = await employeeleavesummarySQL3.employeeleavesummary(
        startDate: startDate.value!,
        endDate: endDate.value!,
        from: from,
        to: to,
        page: page,
        pageSize: pageSize,
      );

      if (page == 1) {
        data.assignAll(
          newData.map((e) => EmployeeLeaveSummaryModel.fromJson(e)).toList(),
        );
      } else {
        data.addAll(
          newData.map((e) => EmployeeLeaveSummaryModel.fromJson(e)).toList(),
        );
      }

      hasMoreData = newData.length == pageSize;
      currentPage = page;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDataForRange() async {
    currentPage = 1;
    hasMoreData = true;
    await fetchData(page: currentPage, pageSize: pageSize);
  }

  Future<void> updateStartDate(DateTime newStartDate) async {
    startDate.value = newStartDate;
  }

  Future<void> updateEndDate(DateTime newEndDate) async {
    endDate.value = newEndDate;
    await fetchDataForRange();
  }

  void refreshData() {
    fetchData(page: currentPage, pageSize: pageSize);
  }

  void loadMore() {
    if (!hasMoreData || isLoading.value) return;
    fetchData(page: currentPage + 1, pageSize: pageSize);
  }

  void updatePagination(int newPageSize, int newPage) {
    pageSize = newPageSize;
    currentPage = newPage;
    hasMoreData = true;
    fetchData(page: currentPage, pageSize: pageSize);
  }

  void resetDates() {
    startDate.value = DateTime.now();
    endDate.value = DateTime.now();
    fetchDataForRange();
  }
}