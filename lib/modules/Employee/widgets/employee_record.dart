import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Loadingui/Loading_Screen.dart';
import 'package:hrms/modules/Dashboard/models/dashboard_model.dart';

import '../../../Searchbar/view/search_bar_screen.dart';
import '../../Dashboard/controllers/dashboard_recently_screen_controller.dart';
import '../../Dashboard/models/dashboard_model.dart';
import '../Controller/employeefiltercontroller.dart';
import '../views/employee_filter_view.dart';

class EmployeeList extends GetView<EmployeeFilterController> {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildEmployeeResponsive();
  }

  Widget _buildEmployeeResponsive() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildEmployeeMobile() : _buildEmployeeOther();
  }

  Widget _buildEmployeeOther() {
    final controller = Get.find<RecentlyControllerScreen>();

    final ScrollController verticalScroll = ScrollController();
    final ScrollController horizontalScroll = ScrollController();

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title, search bar and filter
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade700,
                    Colors.deepPurpleAccent.shade100,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Employee Records',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: SearchbarScreen(),
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                              width: 200,
                              child: EmployeefilterView(),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.users.isEmpty) {
                return const Center(child: Text('No data available'));
              }

              return Scrollbar(
                controller: verticalScroll,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: verticalScroll,
                  scrollDirection: Axis.vertical,
                  child: Scrollbar(
                    controller: horizontalScroll,
                    thumbVisibility: true,
                    notificationPredicate: (notif) => notif.depth == 1,
                    child: SingleChildScrollView(
                      controller: horizontalScroll,
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(Get.context!).size.width,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('ID Card')),
                              DataColumn(label: Text('Position')),
                              DataColumn(label: Text('Department')),
                              DataColumn(label: Text('Join Date')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: controller.users.map((user) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(user.email)),
                                  DataCell(Text(user.name)),
                                  DataCell(Text(user.id_card)),
                                  DataCell(Text(user.position)),
                                  DataCell(Text(user.department)),
                                  DataCell(Text(user.created_at)),
                                  DataCell(
                                    IconButton(
                                      onPressed: () {
                                        // action
                                      },
                                      icon: const Icon(
                                        Icons.details_outlined,
                                        color: Colors.green,
                                      ),
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
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeMobile() {
    final controller = Get.find<RecentlyControllerScreen>();
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: LoadingScreen());
      }
      if (controller.users.isEmpty) {
        return Center(child: Text('No data available'));
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.users.length,
        itemBuilder: (context, index) {
          final record = controller.users[index];
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            record.email ?? '-',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              // handle details
                            },
                            icon: const Icon(
                              Icons.details,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(record.name ?? '-'),
                      const SizedBox(height: 6),
                      Text(record.id_card ?? '-'),
                      const SizedBox(height: 6),
                      Text(record.position ?? '-'),
                      const SizedBox(height: 6),
                      Text(record.department ?? '-'),
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
