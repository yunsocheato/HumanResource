import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../Utils/Network/Method/method_internet_connection.dart';
import '../API/employee_report_sql1.dart';
import '../Model/employee_checkin_model.dart';

class EmployeeReportController extends GetxController {
  final RxList<EmployeeCheckinModel> data = <EmployeeCheckinModel>[].obs;
  final empoloyeecheckINSQL employeeCheckinSQL = empoloyeecheckINSQL();
  final Nointernetmethod NointernetConnection = Nointernetmethod();
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  int currentPage = 1;
  int pageSize = 100;
  bool hasMoreData = true;

  final isLoading = false.obs;
  final isExporting1 = false.obs;

  Rx<DateTime?> startDate = DateTime.now().obs;
  Rx<DateTime?> endDate = DateTime.now().obs;
  RxBool checkinginternet = false.obs;

  final isPressed1 = false.obs;
  final isPressed2 = false.obs;
  final showlogincard1 = true.obs;
  final showlogincard2 = true.obs;
  final showlogincard3 = true.obs;
  final showlogincard4 = true.obs;
  final Imageasset = 'assets/images/unavailabledata.png'.obs;
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
    checkNetworkAndData();
  }

  @override
  void onClose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    super.onClose();
  }

  Future<void> checkNetworkAndData() async {
    await NointernetConnection.checkServer();

    if (NointernetConnection.networkError.error.value.isNotEmpty) {
      Imageasset.value = 'assets/images/unavailabledata.png';
    } else if (data.isEmpty) {
      Imageasset.value = 'assets/images/unavailabledata.png';
    } else {
      Imageasset.value = '';
    }
  }

  Future<void> fetchData({required int page, required int pageSize}) async {
    if (startDate.value == null || endDate.value == null) return;

    try {
      isLoading.value = true;

      final newData = await employeeCheckinSQL.employeecheckin(
        StartDate: startDate.value!,
        endDate: endDate.value!,
        page: page,
        pageSize: pageSize,
      );

      final mappedData =
          newData.map((e) => EmployeeCheckinModel.fromJson(e)).toList();

      if (page == 1) {
        data.assignAll(mappedData);
      } else {
        data.addAll(mappedData);
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
  }

  String formatDateTime(dynamic date) {
    if (date == null) return '-';

    try {
      if (date is DateTime) {
        return dateFormat.format(date.toLocal());
      }
      if (date is String) {
        final parsed = DateTime.tryParse(date);
        if (parsed != null) {
          return dateFormat.format(parsed.toLocal());
        }
      }

      return '-';
    } catch (e) {
      return '-';
    }
  }
}
