import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Loadingui/Loading_Screen.dart';
import '../../../ErrorScreen/Controller/DataUnavaiable.dart';
import '../../../Searchbar/controller/search_bar_controller.dart';
import '../controllers/attendance_widget_controller.dart';


class AttendanceRecords extends GetView<AttendanceController> {
   AttendanceRecords({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchBarController());
    Get.put(DataUnavailable());
    return BuildResponsiveObxTable();
  }

  Widget BuildResponsiveObxTable() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildAttendanceTableColumn() : _buildAttendanceTableRow();
  }



   Widget _buildAttendanceTableRow() {
     final controller = Get.find<AttendanceController>();
     final data1 = Get.put(DataUnavailable());
     return Obx(() {
       if (controller.isLoading.value) {
         return const Center(child: LoadingScreen());
       } else if (controller.dataSource.value == null || controller.attendanceData.isEmpty) {
         return Obx(() {
           return data1.imageNotFound.value
               ? SizedBox(
             width: 150,
             height: 150,
             child: Center(child: Image.asset(data1.imageUrl, fit: BoxFit.cover)),
           )
               : const Text("No Data Found", style: TextStyle(color: Colors.red));
         });
       }
         final context = Get.context!;
         return SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: ConstrainedBox(
             constraints: BoxConstraints(minWidth: MediaQuery
                 .of(context)
                 .size
                 .width - 64,
             ),
             child: PaginatedDataTable(
               rowsPerPage: controller.currentLimit,
               availableRowsPerPage: const [10, 20, 50, 100, 200],
               onPageChanged: (firstRowIndex) {
                 final newPage = (firstRowIndex ~/ controller.currentLimit);
                 controller.updatePagination(controller.currentLimit, newPage);
               },
               onRowsPerPageChanged: (value) {
                 if (value != null) {
                   controller.updatePagination(value, 0);
                 }
               },
               columns: const [
                 DataColumn(label: Text('Log ID')),
                 DataColumn(label: Text('ID Fingerprint')),
                 DataColumn(label: Text('Username')),
                 DataColumn(label: Text('Clock IN')),
                 DataColumn(label: Text('Check Type')),
               ],
               source: controller.dataSource.value!,
             ),
           ),
         );

     });
   }


   Widget _buildAttendanceTableColumn() {
     final controller = Get.find<AttendanceController>();
     final data = controller.attendanceData;
     final data1 = Get.put(DataUnavailable());
     return Obx(() {
       if (controller.isLoading.value) {
         return const Center(child: LoadingScreen());
       } else if (controller.dataSource.value == null || controller.attendanceData.isEmpty) {
         return Obx(() {
           return data1.imageNotFound.value
               ? SizedBox(
             width: 150,
             height: 150,
             child: Center(child: Image.asset(data1.imageUrl, fit: BoxFit.cover)),
           )
               : const Text("No Data Found", style: TextStyle(color: Colors.red));
         });
       }

       return ListView.builder(
         shrinkWrap: true,
         physics: const NeverScrollableScrollPhysics(),
         itemCount: data.length,
         itemBuilder: (context, index) {
           final record = data[index];
           return Card(
             color: Colors.white,
             margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
             elevation: 2,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12)),
             child: Row(
               children: [
                 Container(
                   width: 6,
                   height: 98,
                   decoration: BoxDecoration(
                     color: Colors.blue.shade900,
                     borderRadius: const BorderRadius.only(
                       topLeft: Radius.circular(12),
                       bottomLeft: Radius.circular(12),
                     ),
                   ),
                 ),
                 const SizedBox(width: 20),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Username: ${record['name'] ?? '-'}",
                           style: const TextStyle(fontWeight: FontWeight.bold)),
                       const SizedBox(height: 4),
                       Text('FingerPrintID: ${record['fingerprint_id']}'),
                       Text("Clock In: ${record['timestamp'] ?? '-'}"),
                       Text("Check Type: ${record['check_type'] ?? '-'}"),
                     ],
                   ),
                 ),
               ],
             ),
           );
         },
       );
     });
   }

}
