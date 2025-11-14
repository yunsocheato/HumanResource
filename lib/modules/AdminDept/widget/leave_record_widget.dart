import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/leave_record_model.dart';
import '../../../Utils/Loadingui/ErrorScreen/error_message.dart';
import '../../../Utils/Loadingui/Loading_skeleton.dart';
import '../controller/leave_record_controller.dart';

class LeaveRequestTablewidget extends GetView<LeaveRecordController> {
  const LeaveRequestTablewidget({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = controller.leaves;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return _buildLeaveRequestsListMobile(context, requests);
        } else {
          return _buildLeaveRequestsTableOther(context);
        }
      },
    );
  }

  Widget _buildLeaveRequestsTableOther(BuildContext context) {
    final controller = Get.find<LeaveRecordController>();
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
        margin: const EdgeInsets.all(16),
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

                            final requests = controller.leaves;

                            if (requests.isEmpty) {
                              return const errormessage(
                                tittle: 'No LeaveRecord Found',
                              );
                            }
                            return DataTable(
                              dataRowHeight: 38,
                              columnSpacing: 20,
                              headingTextStyle: TextStyle(
                                fontSize: fontSize(14),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              dataTextStyle: TextStyle(fontSize: fontSize(13)),
                              columns: [
                                _coloredColumn(
                                  'Name',
                                  Colors.blue,
                                  colWidth(59),
                                  fontSize,
                                ),
                                _coloredColumn(
                                  'Position',
                                  Colors.green,
                                  colWidth(59),
                                  fontSize,
                                ),
                                _coloredColumn(
                                  'Status',
                                  Colors.orange,
                                  colWidth(59),
                                  fontSize,
                                ),
                                _coloredColumn(
                                  'Start Date',
                                  Colors.blueGrey,
                                  colWidth(59),
                                  fontSize,
                                ),
                                _coloredColumn(
                                  'End Date',
                                  Colors.green,
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
                                      color: MaterialStateProperty.resolveWith<
                                        Color?
                                      >(
                                        (Set<MaterialState> states) =>
                                            index.isEven
                                                ? Colors.blue.shade100
                                                : Colors.white,
                                      ),
                                      cells: [
                                        DataCell(
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                request.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: fontSize(10),
                                                ),
                                              ),
                                              Text(
                                                request.position,
                                                style: TextStyle(
                                                  fontSize: fontSize(10),
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
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
                                            request.status,
                                            style: TextStyle(
                                              fontSize: 09,
                                              color: _getStatusColor(
                                                request.status,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller.formatDate(
                                              request.startDate,
                                            ),
                                            style: TextStyle(
                                              fontSize: 09,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            controller.formatDate(
                                              request.endDate,
                                            ),
                                            style: TextStyle(
                                              fontSize: 09,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.info,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                                onPressed:
                                                    () => controller
                                                        .showLeaveDialog(
                                                          request,
                                                        ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 15,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ],
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

  Widget _buildLeaveRequestsListMobile(
    BuildContext context,
    List<LeaveRecordModel> requests,
  ) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Skeletonlines();
      }

      final requests = controller.leaves;

      if (requests.isEmpty) {
        return errormessage(tittle: 'No LeaveRecord Found');
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
                        request.status,
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(request.status),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    request.position,
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
                  Text(
                    request.reason,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    'Start Date',
                    controller.formatDate(request.startDate),
                  ),
                  _infoRow('End Date', controller.formatDate(request.endDate)),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value ?? '-', overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}
