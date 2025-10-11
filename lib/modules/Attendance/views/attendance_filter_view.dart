import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Attendance/utils/ExportExcel.dart';
import 'package:intl/intl.dart';
import '../../Searchbar/view/search_bar_screen.dart';
import '../controllers/attendance_widget_controller.dart';
import '../utils/ExportPDF.dart';

class AttendanceFilterView extends GetView<AttendanceController> {
  const AttendanceFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveTablefilter(context , context);
  }
  Widget _buildResponsiveTablefilter(BuildContext , context){
    final isMobile = Get.width < 600 ;
    final context = Get.context ;
    return isMobile ?  _buildAttendanceTablefilterMobile(context!):_buildAttendanceTablefilterother( controller: controller, selectedFilter: controller.selectedFilter, selectedExport: controller.selectedExport,) ;
  }
  Widget _buildAttendanceTablefilterMobile(BuildContext context) {
    final filterOptions = ['Filter', 'Username', 'Clock IN', 'Check Type'];
    final exportOptions = ['PDF', 'EXCEL', 'Image'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildDropdown(
                  controller.selectedFilter,
                  filterOptions,
                  const Icon(Icons.filter_alt_off, color: Colors.white),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _pickDate(context, true),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
                  label: Obx(() => Text(
                    controller.startDate.value != null
                        ? DateFormat('yyyy-MM-dd').format(controller.startDate.value!)
                        : 'Start Date',
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _pickDate(context, false),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
                  label: Obx(() => Text(
                    controller.endDate.value != null
                        ? DateFormat('yyyy-MM-dd').format(controller.endDate.value!)
                        : 'End Date',
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
                const SizedBox(width: 8),
                _buildDropdown(
                  controller.selectedExport,
                  exportOptions,
                  const Icon(Icons.import_export, color: Colors.white),
                  onChanged: (String? newValue) async {
                    if (newValue != null) {
                      controller.selectedExport.value = newValue;
                      if (newValue == 'PDF') {
                        await Future.microtask(() => ExportPDF( attendaData: controller.attendanceData));
                      } else if (newValue == 'EXCEL') {
                        await Future.microtask(() => exportToExcel(attendaData: controller.attendanceData));
                      } else if (newValue == 'Image') {
                        Get.snackbar('Coming Soon', 'This feature is coming soon');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTablefilterother({
    required AttendanceController controller,
    required RxString selectedFilter,
    required RxString selectedExport,
  }) {
    final filterOptions = ['Filter', 'Username', 'Clock IN', 'Check Type'];
    final exportOptions = ['PDF', 'EXCEL', 'Image'];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _buildDropdownOther(
          selectedFilter,
          filterOptions,
          const Icon(Icons.filter_alt_off, color: Colors.white),
        ),
        Obx(() => ElevatedButton.icon(
          onPressed: () => _pickDate(Get.context!, true),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
          label: Text(
            controller.startDate.value != null
                ? DateFormat('yyyy-MM-dd').format(controller.startDate.value!)
                : 'Start Date',
            style: const TextStyle(color: Colors.white),
          ),
        )),

        Obx(() => ElevatedButton.icon(
          onPressed: () => _pickDate(Get.context!, false),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
          label: Text(
            controller.endDate.value != null
                ? DateFormat('yyyy-MM-dd').format(controller.endDate.value!)
                : 'End Date',
            style: const TextStyle(color: Colors.white),
          ),
        )),
        _buildDropdownOther(
          selectedExport,
          exportOptions,
          const Icon(Icons.import_export, color: Colors.white),
          onChanged: (String? newValue) async {
            if (newValue != null) {
              selectedExport.value = newValue;
              if (newValue == 'PDF') {
                Future.microtask(() => Get.to(() =>  ExportPDF(attendaData: controller.attendanceData)));
              } else if (newValue == 'EXCEL') {
                Future.microtask(() => exportToExcel(attendaData: controller.attendanceData));
              } else if (newValue == 'Image') {
                Get.snackbar('Coming Soon', 'Image export is coming soon');
              }
            }
          },
        ),
        SearchbarScreen(),
      ],
    );
  }


    Widget _buildDropdown(
      RxString selectedValue,
      List<String> options,
      Icon icon, {
        void Function(String?)? onChanged,
      }) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(() => DropdownButton<String>(
          value: selectedValue.value,
          icon: icon,
          style: const TextStyle(color: Colors.white),
          dropdownColor: Colors.blue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              selectedValue.value = newValue;
              onChanged?.call(newValue);
            }
          },
        )),
      ),
    );
  }
  Widget _buildDropdownOther(
      RxString selectedValue,
      List<String> options,
      Icon icon, {
        void Function(String?)? onChanged,
      }) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(() => DropdownButton<String>(
          value: selectedValue.value,
          icon: icon,
          dropdownColor: Colors.blue,
          style: const TextStyle(color: Colors.white),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              selectedValue.value = newValue;
              onChanged?.call(newValue);
            }
          },
        )),
      ),
    );
  }
  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.updateDate(isStart, picked);
    }
  }
}
