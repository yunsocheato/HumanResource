import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../../../../Utils/Loadingui/ErrorScreen/Controller/DataUnavaiable.dart';
import '../../../../Utils/Loadingui/Loading_Screen.dart';
import '../../../../Utils/Searchbar/controller/search_bar_controller.dart';
import '../controllers/attendance_widget_controller.dart';
import 'attendance_filter_view.dart';
import 'package:intl/intl.dart';

class AttendanceRecords extends GetView<AttendanceController> {
  const AttendanceRecords({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchBarController());
    Get.put(DataUnavailable());

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isLaptop = width >= 1024 && width < 1440;
        final isDesktop = width >= 1440 && width < 2560;
        final isLargeDesktop = width >= 2560;
        double maxTableWidth;
        if (isMobile) {
          maxTableWidth = double.infinity;
        } else if (isTablet) {
          maxTableWidth = width * 0.85;
        } else if (isLaptop) {
          maxTableWidth = width * 0.85;
        } else if (isDesktop) {
          maxTableWidth = width * 0.8;
        } else if (isLargeDesktop) {
          maxTableWidth = width * 0.8;
        } else {
          maxTableWidth = width * 0.9;
        }
        if (isMobile) {
          return _buildAttendanceTableColumn();
        } else {
          return _buildAttendanceTableDesktop(maxTableWidth);
        }
      },
    );
  }

  Widget _buildAttendanceTableDesktop(double maxTableWidth) {
    return Obx(() {
      if (controller.dataSource.value == null ||
          controller.attendanceData.isEmpty) {
        return Center(
          child: Column(
            children: [
              Text(
                'Not Found Attendance',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Image.asset('assets/icon/nodata.png', width: 120, height: 120),
            ],
          ),
        );
      }
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(Get.context!).size.height * 0.6,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      "Attendance Record",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                        fontFamily: '7TH.ttf',
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => showAttendanceDialog(),
                      icon: Icon(Icons.fullscreen, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                AttendanceFilterView(),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: PaginatedDataTable(
                      rowsPerPage: controller.currentLimit,
                      availableRowsPerPage: const [10, 20, 50, 100, 200],
                      onPageChanged: (firstRowIndex) {
                        final newPage =
                            (firstRowIndex ~/ controller.currentLimit);
                        controller.updatePagination(
                          controller.currentLimit,
                          newPage,
                        );
                      },
                      onRowsPerPageChanged: (value) {
                        if (value != null) {
                          controller.updatePagination(value, 0);
                        }
                      },
                      columns: [
                        DataColumn(
                          label: Container(
                            height: 30,
                            width: 125,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'ID Fingerprint',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            height: 30,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Username',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            height: 30,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Check Type',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            height: 30,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Clock In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                      source: controller.dataSource.value!,
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

  Widget _buildAttendanceTableColumn() {
    final controller = Get.find<AttendanceController>();
    final data1 = Get.put(DataUnavailable());

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 900;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "ATTENDANCE RECORDS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.blue.shade900,
                  fontFamily: '7TH.ttf',
                ),
              ),
            ),
            const SizedBox(height: 15),
            const AttendanceFilterView(),
            const SizedBox(height: 15),
            Obx(() {
              final data = controller.attendanceData;

              if (controller.isLoading.value) {
                return const Center(child: LoadingScreen());
              }

              if (controller.dataSource.value == null || data.isEmpty) {
                return Center(
                  child:
                      data1.imageNotFound.value
                          ? SizedBox(
                            width: 150,
                            height: 150,
                            child: Image.asset(
                              data1.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                          : const Text(
                            "No Data Found",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                );
              }

              if (isMobile) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final record = data[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 6,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    bottomLeft: Radius.circular(14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 6,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        record['username'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _infoRow(
                                        "Fingerprint ID",
                                        record['fingerprint_id'],
                                      ),
                                      _infoRow(
                                        "Clock In",
                                        formatDate(record['timestamp']),
                                      ),
                                      _infoRow("Type", record['check_type']),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return SizedBox(
                height: 600,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final record = data[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          record['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fingerprint ID: ${record['fingerprint_id'] ?? '-'}',
                              ),
                              Text(
                                'Clock-in: ${formatDate(record['timestamp'])}',
                              ),
                              Text('Type: ${record['check_type'] ?? '-'}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _infoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        "$label: ${value ?? '-'}",
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  String formatDate(String timestamp) {
    final date = DateTime.parse(timestamp);
    final formatter = DateFormat('hh:mm a dd.MM.yyyy');
    return formatter.format(date);
  }

  void showAttendanceDialog() {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Obx(() {
              if (controller.dataSource.value == null ||
                  controller.attendanceData.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No Attendance Found',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/icon/nodata.png',
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Attendance Record",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                            fontFamily: '7TH.ttf',
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.close, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    AttendanceFilterView(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          width: MediaQuery.of(Get.context!).size.width,
                          child: PaginatedDataTable(
                            header: const SizedBox(),
                            rowsPerPage: controller.currentLimit,
                            availableRowsPerPage: const [10, 20, 50, 100, 200],
                            onPageChanged: (firstRowIndex) {
                              final newPage =
                                  (firstRowIndex ~/ controller.currentLimit);
                              controller.updatePagination(
                                controller.currentLimit,
                                newPage,
                              );
                            },
                            onRowsPerPageChanged: (value) {
                              if (value != null) {
                                controller.updatePagination(value, 0);
                              }
                            },
                            columns: [
                              DataColumn(
                                label: _buildHeader(
                                  'ID Fingerprint',
                                  Colors.green,
                                  125,
                                ),
                              ),
                              DataColumn(
                                label: _buildHeader(
                                  'Username',
                                  Colors.red,
                                  100,
                                ),
                              ),
                              DataColumn(
                                label: _buildHeader(
                                  'Check Type',
                                  Colors.orange,
                                  100,
                                ),
                              ),
                              DataColumn(
                                label: _buildHeader(
                                  'Clock In',
                                  Colors.purple,
                                  100,
                                ),
                              ),
                            ],
                            source: controller.dataSource.value!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildHeader(String text, Color color, double width) {
    return Container(
      height: 30,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
