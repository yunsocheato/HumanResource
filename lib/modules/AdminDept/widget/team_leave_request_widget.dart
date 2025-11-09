import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/Loadingui/Loading_skeleton.dart';
import 'package:hrms/modules/AdminDept/controller/leave_record_controller.dart';
import 'package:intl/intl.dart';

import '../../../Utils/Loadingui/ErrorScreen/error_message.dart';
import '../Utils/date_picker_by_date_team_leave.dart';

class TeamRequestLeaveResponsiveWidget extends GetView<LeaveRecordController> {
  const TeamRequestLeaveResponsiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.currentUserRole.value != 'admindept' &&
          controller.currentUserRole.value != 'admin' &&
          controller.currentUserRole.value != 'superadmin') {
        return const SizedBox.shrink();
      }

      final leaves = controller.leavesDepartments.toList();
      final dateFormat = DateFormat('dd/MM/yyyy');
      final _ = MediaQuery.of(context).size.width;
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

      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return ListView.builder(
              itemCount: leaves.length,
              itemBuilder: (context, index) {
                final leave = leaves[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('${leave.name} - ${leave.status}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reason: ${leave.reason}'),
                        Text(
                          'Dates: ${leave.startDate != null ? dateFormat.format(leave.startDate!) : '-'}'
                          ' - ${leave.endDate != null ? dateFormat.format(leave.endDate!) : '-'}',
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leave.status == 'pending') ...[
                          IconButton(
                            icon: Icon(Icons.check_circle, color: Colors.green),
                            onPressed:
                                () => controller.showApproveDialog(
                                  context,
                                  leave.id,
                                ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed:
                                () => controller.showRejectDialog(
                                  context,
                                  leave.id,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TEAM REQUEST LEAVE',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const DatePickerTeamLeave(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Card(
                  elevation: 15,
                  color: Colors.white,
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                                      minWidth: constraints.minWidth,
                                    ),
                                    child: Obx(() {
                                      if (controller.isLoading.value) {
                                        return const Center(
                                          child: Skeletonlines(),
                                        );
                                      }

                                      if (controller
                                          .leavesDepartments
                                          .isEmpty) {
                                        return const errormessage(
                                          tittle: 'No Team RequestLeave Found',
                                        );
                                      }
                                      return DataTable(
                                        dataRowHeight: 35,
                                        columnSpacing: 20,
                                        columns: [
                                          _coloredColumn(
                                            'Staff Name',
                                            Colors.blue,
                                            colWidth(59),
                                            fontSize,
                                          ),
                                          _coloredColumn(
                                            'Status',
                                            Colors.green,
                                            colWidth(59),
                                            fontSize,
                                          ),
                                          _coloredColumn(
                                            'Submit',
                                            Colors.orange,
                                            colWidth(59),
                                            fontSize,
                                          ),
                                          _coloredColumn(
                                            'Reason',
                                            Colors.blueGrey,
                                            colWidth(59),
                                            fontSize,
                                          ),
                                          _coloredColumn(
                                            'Dates',
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
                                            leaves.asMap().entries.map((entry) {
                                              final index = entry.key;
                                              final leave = entry.value;
                                              return DataRow(
                                                color:
                                                    MaterialStateProperty.resolveWith<
                                                      Color?
                                                    >(
                                                      (
                                                        Set<MaterialState>
                                                        states,
                                                      ) =>
                                                          index.isEven
                                                              ? Colors
                                                                  .blue
                                                                  .shade100
                                                              : Colors.white,
                                                    ),
                                                cells: [
                                                  DataCell(
                                                    Text(
                                                      leave.name,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),

                                                  DataCell(
                                                    Text(
                                                      leave.status,
                                                      style: TextStyle(
                                                        color: _getStatusColor(
                                                          leave.status,
                                                        ),
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                  // DataCell(
                                                  //   leave.nextUserIds.isNotEmpty
                                                  //       ? Text(
                                                  //         leave.nextUserIds
                                                  //             .join(', '),
                                                  //       )
                                                  //       : const Text('-'),
                                                  // ),
                                                  DataCell(
                                                    Text(
                                                      leave.currentStage,
                                                      style: (TextStyle(
                                                        fontSize: 10,
                                                      )),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      leave.reason,
                                                      style: (TextStyle(
                                                        fontSize: 10,
                                                      )),
                                                    ),
                                                  ),

                                                  DataCell(
                                                    Text(
                                                      '${leave.startDate != null ? dateFormat.format(leave.startDate!) : '-'}'
                                                      ' - ${leave.endDate != null ? dateFormat.format(leave.endDate!) : '-'}',
                                                      style: (TextStyle(
                                                        fontSize: 10,
                                                      )),
                                                    ),
                                                  ),

                                                  DataCell(
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.info_outline,
                                                            size: 13,
                                                          ),
                                                          color: Colors.black54,
                                                          onPressed:
                                                              () => controller
                                                                  .showLeaveDialog(
                                                                    leave,
                                                                  ),
                                                        ),
                                                        if (leave.status ==
                                                                'pending' ||
                                                            leave.status ==
                                                                'in_progress') ...[
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.green,
                                                              size: 13,
                                                            ),
                                                            onPressed: () async {
                                                              final currentRole =
                                                                  controller
                                                                      .currentUserRole
                                                                      .value
                                                                      .toLowerCase();
                                                              if (currentRole ==
                                                                  'superadmin') {
                                                                await controller
                                                                    .approveLeave(
                                                                      leave.id,
                                                                      null,
                                                                    );

                                                                Get.snackbar(
                                                                  'Success',
                                                                  'Leave approved successfully.',
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                );
                                                              } else {
                                                                controller
                                                                    .showApproveDialog(
                                                                      context,
                                                                      leave.id,
                                                                    );
                                                              }
                                                            },
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                              size: 13,
                                                            ),
                                                            onPressed:
                                                                () => controller
                                                                    .showRejectDialog(
                                                                      context,
                                                                      leave.id,
                                                                    ),
                                                          ),
                                                        ],
                                                        if (leave.status ==
                                                            'approved') ...[
                                                          if (leave.status ==
                                                              'approved') ...[
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        6,
                                                                  ),
                                                              child: Text(
                                                                'Approved',
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ],
                                                        if (leave.status ==
                                                            'rejected') ...[
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  horizontal: 6,
                                                                ),
                                                            child: Text(
                                                              'Rejected',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                        if (controller
                                                                    .currentUserRole
                                                                    .value ==
                                                                'admin' ||
                                                            controller
                                                                    .currentUserRole
                                                                    .value ==
                                                                'admindept' ||
                                                            controller
                                                                    .currentUserRole
                                                                    .value ==
                                                                'superadmin') ...[
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 13,
                                                            ),
                                                            tooltip: "Delete",
                                                            onPressed: () {},
                                                            // onPressed:
                                                            //     () => controller
                                                            //         .deleteLeave(
                                                            //           leave.id,
                                                            //         ),
                                                          ),
                                                        ],
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
              ),
            ],
          );
        },
      );
    });
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.blue.shade900;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.green.shade900;
      default:
        return Colors.grey;
    }
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
}
