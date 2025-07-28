import 'package:get/get.dart';
import '../../Attendance/utils/ExportExcel.dart';
import '../../Attendance/utils/ExportPDF.dart';

class EmployeeFilterController extends GetxController {
  final RxString selectedFilter = 'Filter'.obs;
  final RxString selectedExport = 'EXCEL'.obs;

  final RxList<Map<String, dynamic>> allData = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
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
  }

