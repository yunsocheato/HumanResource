import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:intl/intl.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../../../../Utils/SnackBar/snack_bar.dart';
import '../controllers/leave_controller.dart';
import '../views/Leave_view_filter.dart';

class leaverequesttable extends GetView<LeaveController> {
  const leaverequesttable({super.key});
  @override
  Widget build(BuildContext context) {
    final LeaveController controller = Get.find<LeaveController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final requests = controller.filteredRequests;

      if (requests.isEmpty) {
        return const Center(child: Text('No pending leave requests found'));
      }

      final isMobile = Get.width < 600;
      return isMobile
          ? _buildLeaveRequestsListMobile(context, requests)
          : _buildLeaveRequestsTableOther(context);
    });
  }

  Widget _buildLeaveRequestsTableOther(BuildContext context) {
    final controller = Get.find<LeaveController>();
    final ScrollController horizontalController = ScrollController();
    final HoverMouseController controller1 = Get.put(HoverMouseController());

    return Obx(() {
      final requests = controller.leaveRequests;
      return MouseHover(
        keyId: 12,
        controller: controller1,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade300],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: const Text(
                              'Leave Records',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LeaveViewFilter(),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: horizontalController,
                    child: SingleChildScrollView(
                      controller: horizontalController,
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            headingRowHeight: 30,
                            sortAscending: true,
                            columnSpacing: 12.0,
                            dataRowMaxHeight: double.infinity,
                            dataRowMinHeight: 60,
                            dividerThickness: 1,
                            headingTextStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            dataTextStyle: const TextStyle(fontSize: 12),
                            columns: const [
                              DataColumn(label: Text('Employee')),
                              DataColumn(label: Text('Department')),
                              DataColumn(label: Text('Position')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Start Date')),
                              DataColumn(label: Text('End Date')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows:
                                requests.map((request) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              request['name'] ?? '-',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              request['user_email'] ?? '-',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DataCell(
                                        Text(request['department'] ?? '-'),
                                      ),
                                      DataCell(
                                        Text(request['position'] ?? '-'),
                                      ),
                                      DataCell(Text(request['status'] ?? '-')),
                                      DataCell(
                                        Text(
                                          request['from_date'] != null
                                              ? DateFormat(
                                                'MMM d, yyyy',
                                              ).format(
                                                DateTime.parse(
                                                  request['from_date'],
                                                ),
                                              )
                                              : '-',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          request['to_date'] != null
                                              ? DateFormat(
                                                'MMM d, yyyy',
                                              ).format(
                                                DateTime.parse(
                                                  request['to_date'],
                                                ),
                                              )
                                              : '-',
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.check_circle_outline,
                                              ),
                                              color: Colors.green,
                                              tooltip: 'Approve',
                                              onPressed: () async {
                                                try {
                                                  await controller.updateStatus(
                                                    request['request_id'],
                                                    'approved',
                                                  );
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        showAwesomeSnackBarGetx(
                                                          'Success',
                                                          'Request Approved',
                                                          ContentType.success,
                                                        );
                                                      });
                                                } catch (e) {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        showAwesomeSnackBarGetx(
                                                          "Error",
                                                          "Error $e",
                                                          ContentType.failure,
                                                        );
                                                      });
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.cancel_outlined,
                                              ),
                                              color: Colors.red,
                                              tooltip: 'Reject',
                                              onPressed: () async {
                                                try {
                                                  await controller.updateStatus(
                                                    request['request_id'],
                                                    'rejected',
                                                  );
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        showAwesomeSnackBarGetx(
                                                          "Request",
                                                          "Request Rejected",
                                                          ContentType.failure,
                                                        );
                                                      });
                                                } catch (e) {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        showAwesomeSnackBarGetx(
                                                          "Error",
                                                          "Error $e",
                                                          ContentType.failure,
                                                        );
                                                      });
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.info_outline,
                                              ),
                                              tooltip: 'View Details',
                                              onPressed:
                                                  () => controller
                                                      .showLeaveDialog(request),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLeaveRequestsListMobile(
    BuildContext context,
    List<Map<String, dynamic>> requests,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      request['name'] ?? '-',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      request['status'] ?? '-',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(request['status']),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  request['user_email'] ?? '-',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),

                _infoRow('Department', request['department']),
                _infoRow('Position', request['position']),
                _infoRow(
                  'Start Date',
                  request['from_date'] != null
                      ? DateFormat(
                        'MMM d, yyyy',
                      ).format(DateTime.parse(request['from_date']))
                      : '-',
                ),
                _infoRow(
                  'End Date',
                  request['to_date'] != null
                      ? DateFormat(
                        'MMM d, yyyy',
                      ).format(DateTime.parse(request['to_date']))
                      : '-',
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Approved',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          await controller.updateStatus(
                            request['request_id'],
                            'approved',
                          );
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showAwesomeSnackBarGetx(
                              "Success",
                              "Request Approved",
                              ContentType.success,
                            );
                          });
                        } catch (e) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showAwesomeSnackBarGetx(
                              "Error",
                              "Error $e",
                              ContentType.failure,
                            );
                          });
                        }
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          await controller.updateStatus(
                            request['request_id'],
                            'rejected',
                          );
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showAwesomeSnackBarGetx(
                              "Request",
                              "Request Rejected",
                              ContentType.failure,
                            );
                          });
                        } catch (e) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showAwesomeSnackBarGetx(
                              "Error",
                              "Error $e",
                              ContentType.failure,
                            );
                          });
                        }
                      },
                    ),
                    TextButton(
                      onPressed: () => controller.showLeaveDialog(request),
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
