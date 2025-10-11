import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Attendance/utils/ExportExcel.dart';
import '../../Attendance/utils/ExportPDF.dart';
import '../../Dashboard/API/dashboard_stream_recently1_sql.dart';
import '../../Dashboard/models/dashboard_model.dart';

class EmployeeFilterController extends GetxController {
  final RxString selectedFilter = 'Filter'.obs;
  final RxString selectedExport = 'EXCEL'.obs;

  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  final RxString errorMessage1 = ''.obs;
  final RxList<Map<String, dynamic>> allData = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredData = <Map<String, dynamic>>[].obs;

  RxList<DashboardModel> users = <DashboardModel>[].obs;
  var isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    loadUsers();
    filteredData.assignAll(allData);
  }

  void setData(List<Map<String, dynamic>> attendanceData) {
    allData.assignAll(attendanceData);
    applyFilter(selectedFilter.value);
  }

  void applyFilter(String filterValue) {
    selectedFilter.value = filterValue;
    filterData();
  }

  void filterData() {
    if (selectedFilter.value == 'All' || selectedFilter.value == 'Filter') {
      filteredData.assignAll(allData);
    } else {
      filteredData.assignAll(
          allData.where((element) =>
          element['status']?.toString().toLowerCase() ==
              selectedFilter.value.toLowerCase())
      );
    }
  }


    void exportSheet() {
      if (selectedExport.value == 'PDF') {
        ExportPDF(attendaData: filteredData);
      } else {
        exportToExcel(attendaData: filteredData);
      }
    }

  Future<void> loadUsers() async {
    try {
      final result = await FetchUserasModel();
      users.value = result;
    } catch (e) {
      errorMessage1.value = "User fetch error: $e";
    } finally {
      isLoading.value = false;
    }
  }


}

