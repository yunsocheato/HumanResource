import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/attendance_record_model.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_controller.dart';
import '../../../Utils/Loadingui/ErrorScreen/error_message.dart';
import '../../../Utils/Loadingui/Loading_skeleton.dart';

class AttendanceTablewidget extends GetView<Attendancecontroller> {
  const AttendanceTablewidget({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = controller.attendance;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return _buildAttendanceTableListMobile(context, requests);
        } else {
          return _buildAttendanceTableOther(context);
        }
      },
    );
  }

  Widget _buildAttendanceTableOther(BuildContext context) {
    final controller = Get.find<Attendancecontroller>();
    final width = MediaQuery.of(context).size.width;

    double fontSize(double base) {
      if (width >= 1600) return base * 1.3;
      if (width >= 1200) return base * 1.1;
      if (width >= 1000) return base * 5.6;
      return base * 0.9;
    }

    double colWidth(double base) {
      if (width >= 1600) return base * 1.5;
      if (width >= 1200) return base * 1.3;
      if (width >= 1000) return base * 1.6;
      return base;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                          ),
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return Skeletonlines();
                            }

                            final requests = controller.attendance;
                            if (requests.isEmpty) {
                              return const errormessage(
                                tittle: 'No Attendance Found',
                              );
                            }
                            return DataTable(
                              dataRowHeight: 35,
                              columnSpacing: 20,
                              dataTextStyle: TextStyle(fontSize: fontSize(13)),
                              columns: [
                                _coloredColumn(
                                  'Name',
                                  Colors.blue,
                                  colWidth(59),
                                  fontSize,
                                ),
                                _coloredColumn(
                                  'Department',
                                  Colors.green,
                                  colWidth(59),
                                  fontSize,
                                ),
                                _coloredColumn(
                                  'Type',
                                  Colors.red,
                                  colWidth(59),
                                  fontSize,
                                ),
                                _coloredColumn(
                                  'DateTimes',
                                  Colors.orange,
                                  colWidth(59),
                                  fontSize,
                                ),
                                _coloredColumn(
                                  'Actions',
                                  Colors.redAccent,
                                  colWidth(59),
                                  fontSize,
                                ),
                              ],
                              rows:
                                  requests.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final request = entry.value;
                                    return DataRow(
                                      color: WidgetStateProperty.resolveWith<
                                        Color?
                                      >(
                                        (Set<WidgetState> states) =>
                                            index.isEven
                                                ? Colors.blue.shade100
                                                : Colors.white,
                                      ),
                                      cells: [
                                        DataCell(
                                          Text(
                                            request.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: fontSize(10),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            request.department,
                                            style: TextStyle(fontSize: 09),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            request.check_type,
                                            style: TextStyle(fontSize: 09),
                                          ),
                                        ),

                                        DataCell(
                                          Text(
                                            controller.formatDate(request.date),
                                            style: TextStyle(fontSize: 09),
                                          ),
                                        ),
                                        DataCell(
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataColumn _coloredColumn(
    String title,
    Color color,
    double width,
    double Function(double) fontSize,
  ) {
    return DataColumn(
      label: Container(
        height: 30,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize(9),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceTableListMobile(
    BuildContext context,
    List<AttendanceRecordModel> requests,
  ) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Skeletonlines();
      }
      if (requests.isEmpty) {
        return const errormessage(tittle: 'No Attendance Found');
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        request.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        controller.formatDate(request.date),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    request.check_type,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    request.department,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
