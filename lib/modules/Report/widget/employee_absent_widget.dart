import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../API/DataSourceTableReport.dart';
import '../API/DatableReportAbsent.dart';
import '../controller/employee_report_controller2.dart';
import '../controller/employee_report_controller3.dart';
import 'ExportExcel2.dart';

class EmployeeAbsentWidget extends GetView<EmployeeReportController3> {
  const EmployeeAbsentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveContent();
  }

  Widget _buildResponsiveContent() {
    final context = Get.context;
    final isMobile = MediaQuery.of(context!).size.width < 600;
    return isMobile
        ? _buildEmployeeAbsentMobile()
        : _buildEmployeeAbsentOther();
  }

  Widget _buildEmployeeAbsentMobile() {
    final controller = Get.find<EmployeeReportController3>();

    return Card(
      color: Colors.grey.withOpacity(0.4),
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.6),
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: LoadingScreen());
        }
        if (controller.Imageasset.isEmpty) {
          return Center(
            child: Image.asset(
              controller.Imageasset.value,
              height: 150,
              width: 150,
            ),
          );
        }

        final dataSource = DataSourceTableReportAbsent(controller.data);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(Get.context!).size.width - 45,
              ),
              child: PaginatedDataTable(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Employee Late')],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextButton(
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: Get.context!,
                                initialDate: controller.startDate.value,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null)
                                controller.updateStartDate(picked);
                            },
                            child: Text(
                              'StartDate',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextButton(
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: Get.context!,
                                initialDate: controller.endDate.value,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null)
                                controller.updateEndDate(picked);
                            },
                            child: Text(
                              'EndDate',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Obx(
                              () => Container(
                            height: 30,
                            width: 170,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Text(
                                '${controller.startDate.value?.toLocal().toString().split(' ')[0]} '
                                    'To '
                                    '${controller.endDate.value?.toLocal().toString().split(' ')[0]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextButton(
                            onPressed: () async {
                              controller.isExporting1.value = true;
                              try {
                                await ExportExcel2();
                                Get.snackbar(
                                  'Success',
                                  'Excel exported successfully',
                                );
                              } catch (e) {
                                Get.snackbar('Error', 'Export failed: $e');
                              } finally {
                                controller.isExporting1.value = false;
                              }
                            },
                            child: Obx(
                                  () => Flexible(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    controller.isExporting1.value
                                        ? 'Exporting'
                                        : 'Excel',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                columns: [
                  DataColumn(
                    label: Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Staff_ID',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Position',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 85,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Department',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 85,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Absent_Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 85,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Reason',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 85,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'DateTime',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                source: dataSource,
                rowsPerPage: controller.pageSize,
                onRowsPerPageChanged: (value) {
                  controller.updatePagination(value!, 1);
                },
                showCheckboxColumn: false,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEmployeeAbsentOther() {
    final controller = Get.find<EmployeeReportController3>();
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: LoadingScreen());
      }
      if (controller.Imageasset.isEmpty) {
        return Center(
          child: Image.asset(
            controller.Imageasset.value,
            height: 150,
            width: 150,
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.data.length,
        itemBuilder: (context, index) {
          final record = controller.data[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade900,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Staff_ID: ${record.staff_id ?? '-'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('Username: ${record.staff_name ?? '-'}'),
                      const SizedBox(height: 5),
                      Text('Position: ${record.position ?? '-'}'),
                      const SizedBox(height: 5),
                      Text('Department: ${record.department ?? '-'}'),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text('AbsentDate: ${record.absent_date ?? '-'}'),
                          const SizedBox(width: 5),
                          Text(' Reason ${record.reason ?? '-'}'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('Created At: ${record.created_at ?? '-'}'),
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
