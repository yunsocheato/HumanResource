import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../API/DataSourceTableReport.dart';
import '../controller/employee_report_controller1.dart';
import 'ExportExcel1.dart';

class EmployeeScreenCheckinReport extends GetView<EmployeeReportController>{
  const EmployeeScreenCheckinReport({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildResponsiveContent();
  }


  Widget _buildResponsiveContent() {
    final context = Get.context;
    final isMobile = MediaQuery.of(context!).size.width < 600;
    return isMobile ?  _buildEmployeeCheckINMobile()  : _buildEmployeeCheckINOther() ;
  }

  Widget _buildEmployeeCheckINOther() {
    final controller = Get.find<EmployeeReportController>();

    return Card(
      color: Colors.grey.withOpacity(0.4),
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.6),
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        if(controller.isLoading.value) {
          return Center(child: LoadingScreen());
        }
        if (controller.data.isEmpty) {
          return Center(child: Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/unavailabledata.png')));
        }

        final dataSource = DataSourceTableReport(controller.data);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(Get.context!).size.width - 45,
              ),
              child: PaginatedDataTable(
                header:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Employee Check-In'),
                      ],
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
                              if (picked != null) controller.updateStartDate(picked);
                            },
                            child: Text('StartDate', style: TextStyle(color: Colors.white)),
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
                              if (picked != null) controller.updateEndDate(picked);
                            },
                            child: Text('EndDate', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Obx(() => Container(
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
                              style: TextStyle(color: Colors.white,fontSize: 10),
                            ),
                          ),
                        )),
                        SizedBox(width: 10),
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextButton(
                            onPressed: () async {
                              controller.isExporting1.value = true;
                              try {
                                await Future.microtask(() => ExportExcel1());
                              } finally {
                                controller.isExporting1.value = false;
                              }
                            },
                            child: Obx(() => Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      controller.isExporting1.value ? 'Exporting...' : 'Excel',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const Icon(Icons.download_outlined, color: Colors.white),
                              ],
                            ))
                          ),
                        )
                      ],
                    )
                  ],
                ),
                columns: [
                  DataColumn(label: Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text('ID', style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))))),
                  DataColumn(label: Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text('Fingerprint', style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))))),
                  DataColumn(label: Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text('Username', style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))))),
                  DataColumn(label: Container(
                      width: 85,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text('Check Type', style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))))),
                  DataColumn(label: Container(
                      width: 85,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text('Date Time', style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))))),
                ],
                source: dataSource,
                rowsPerPage: controller.pageSize,
                onRowsPerPageChanged: (value) {
                  controller.updatePagination(value!, 1);
                  controller.loadMore();
                },
                showCheckboxColumn: false,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEmployeeCheckINMobile() {
    final controller = Get.find<EmployeeReportController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: LoadingScreen());
      }
      if (controller.data.isEmpty) {
        return Center(child: Text('No data available'));
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
                borderRadius: BorderRadius.circular(12)),
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
                            record.id.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                       ),
                      const SizedBox(height: 5),
                      Text(record.username ?? '-'),
                      const SizedBox(height: 6),
                      Text(record.fingerprint_id.toString()),
                      const SizedBox(height: 6),
                      Text(record.check_type ?? '-'),
                      const SizedBox(height: 6),
                      Text(record.created_at ?? '-'),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

}