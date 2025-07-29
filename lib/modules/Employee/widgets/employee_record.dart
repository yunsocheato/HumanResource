import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Loadingui/Loading_Screen.dart';
import '../../../Searchbar/view/search_bar_screen.dart';
import '../../Dashboard/controllers/dashboard_recently_screen_controller.dart';
import '../Controller/Employeetable_controller.dart';
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
    final controller1 = Get.find<EmployeeTalbeController>();
    final ScrollController _horizontalController = ScrollController();

    final context = Get.context! ;
    return Obx(() {
      return SizedBox(
        height: MediaQuery.of(context).size.width * 0.3,
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
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade900, Colors.purpleAccent.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: const Text(
                            'Employee Records',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: const [
                            EmployeefilterView(),
                            SizedBox(width: 8),
                            SearchbarScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _horizontalController,
                  child: SingleChildScrollView(
                    controller: _horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: DataTable(
                          headingTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          dataTextStyle: const TextStyle(fontSize: 12),
                          columns: const [
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('ID Card')),
                            DataColumn(label: Text('Position')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: controller.users.map((user) {
                            return DataRow(
                              cells: [
                                DataCell(Text(user.email ?? '-')),
                                DataCell(Text(user.name ?? '-')),
                                DataCell(Text(user.id_card ?? '-')),
                                DataCell(Text(user.position ?? '-')),
                                DataCell(
                                  IconButton(
                                    onPressed: () => controller1.showLeaveDialog(user.toJson()),
                                    icon: const Icon(Icons.info, color: Colors.grey),
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
      );
    });

  }


  Widget _buildEmployeeMobile() {
    final controller = Get.find<RecentlyControllerScreen>();
    final controller1 = Get.find<EmployeeTalbeController>();
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
                            onPressed: () => controller1.showLeaveDialog(record.toJson()),
                            icon: const Icon(
                              Icons.info_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(record.name ?? '-'),
                      const SizedBox(height: 6),
                      Text(record.id_card ?? '-'),
                      const SizedBox(height: 6),
                      Text(record.position ?? '-'),
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
