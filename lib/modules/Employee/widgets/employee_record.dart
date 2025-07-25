import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Dashboard/controllers/dashboard_recently_screen_controller.dart';

class EmployeeList extends GetView<RecentlyControllerScreen> {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedValue = 'EXCEL';
    final controller = Get.find<RecentlyControllerScreen>();
    return SizedBox(
      height: 800,
      width: double.infinity,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Employee Records',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedValue,
                              icon: const Icon(
                                Icons.import_export,
                                color: Colors.white,
                              ),
                              style: TextStyle(color: Colors.white),
                              items:
                                  ['PDF', 'EXCEL', 'Image']
                                      .map(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(value),
                                              ),
                                            ),
                                      )
                                      .toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  selectedValue = newValue;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.users.isEmpty) {
                  return Center(child: Text('No data available'));
                }
                return Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // To allow horizontal scroll if needed
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width - 64,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('id_card')),
                              DataColumn(label: Text('Position')),
                              DataColumn(label: Text('Department')),
                              DataColumn(label: Text('Join Date')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows:
                                controller.users.map((user) {
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
                                          onPressed: () {},
                                          icon: Icon(
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
