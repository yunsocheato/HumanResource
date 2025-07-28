import 'package:get/get.dart';
import 'package:hrms/modules/Attendance/utils/ExportExcel.dart';
import 'package:hrms/modules/Attendance/utils/ExportPDF.dart';

import '../API/attendance_stream_api_sql.dart';
import '../widgets/attendance_data_source_table.dart';
import '../widgets/attendance_picker_date.dart';

class AttendanceController extends GetxController {
  final RxList<Map<String, dynamic>> attendanceData =
      <Map<String, dynamic>>[].obs;
  final Rx<DataTableSourceAttendance?> dataSource =
      Rx<DataTableSourceAttendance?>(null);

  final RxBool isLoading = true.obs;
  final Rxn<DateTime> startDate = Rxn<DateTime>();
  final Rxn<DateTime> endDate = Rxn<DateTime>();
  final RxString selectedFilter = 'Filter'.obs;
  final RxString selectedExport = 'EXCEL'.obs;
  final RxString searchText = ''.obs;

  final RxList<Map<String, dynamic>> allData = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredData = <Map<String, dynamic>>[].obs;

  int currentLimit = 100;
  int currentPage = 0;

  void updateDate(bool isStart, DateTime picked) {
    if (isStart) {
      startDate.value = picked;
    } else {
      endDate.value = picked;
    }
    applyFilter();
  }

  @override
  void onInit() {
    super.onInit();
    buildAttendanceTable(limit: currentLimit, page: currentPage);
  }

  Future<void> buildAttendanceTable({
    required int limit,
    required int page,
  }) async {
    try {
      isLoading.value = true;
      final offset = page * limit;

      final data = await getAttendanceData(limit: limit, offset: offset, page: 0); // <-- IMPORTANT
      attendanceData.value = data;
      dataSource.value = DataTableSourceAttendance(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch attendance data');
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    filteredData.value = allData.where((item) {
      final username = item['username']?.toString().toLowerCase() ?? '';
      final checkType = item['check_type']?.toString().toLowerCase() ?? '';
      final clockIn = DateTime.tryParse(item['clockin'] ?? '') ?? DateTime(2000);

      final matchDate =
          (startDate.value == null || !clockIn.isBefore(startDate.value!)) &&
              (endDate.value == null || !clockIn.isAfter(endDate.value!));

      final matchSearch = searchText.value.isEmpty ||
          (selectedFilter.value == 'Username' &&
              username.contains(searchText.value.toLowerCase())) ||
          (selectedFilter.value == 'Check Type' &&
              checkType.contains(searchText.value.toLowerCase())) ||
          (selectedFilter.value == 'Clock IN' &&
              item['clockin']?.contains(searchText.value) == true);

      return matchDate && matchSearch;
    }).toList();
  }
  void searchData(String query) {
    searchText.value = query;
    applyFilter();
  }

  void filterSheet(){
    ExportPDF( attendaData: attendanceData);
    exportToExcel( attendaData: attendanceData);
  }



  void refreshData() {
    buildAttendanceTable(limit: currentLimit, page: currentPage);
  }

  void updatePagination(int limit, int page) {
    currentLimit = limit;
    currentPage = page;
    buildAttendanceTable(limit: limit, page: page);
  }
}
