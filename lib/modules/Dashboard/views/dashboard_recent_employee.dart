import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_recently_screen_controller.dart';
import '../controllers/dashboard_screen_controller.dart';

class Recentemployee extends GetView<RecentlyControllerScreen> {

  const Recentemployee({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;
        if (isMobile) {
          return buildOBxResponsiveColumn(context, isMobile: isMobile);
        } else if (isTablet) {
          return buildOBxResponsiveRow(context);
        } else if (isDesktop) {
          return buildOBxResponsiveRow(context);
        } else {
          return buildOBxResponsiveRow(context);
        }
        },
    );
  }
  Widget buildOBxResponsiveRow(BuildContext context) {
    final controller = Get.find<RecentlyControllerScreen>();

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
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
                  Text(
                    'Recent Employees',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Action for View All
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Table Content
          Obx(() {
            if (controller.isLoading.value) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (controller.users.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Text('No data available')),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 64,
                ),
                child: DataTable(
                  columnSpacing: 24,
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Position')),
                    DataColumn(label: Text('Department')),
                  ],
                  rows: controller.users.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(Text(user.name)),
                        DataCell(Text(user.email)),
                        DataCell(Text(user.position)),
                        DataCell(Text(user.department)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildOBxResponsiveColumn(BuildContext context, {required bool isMobile}) {
    final controller = Get.find<RecentlyControllerScreen>();
    final Dcontroller = Get.find<DashboardController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.users.isEmpty) {
        return const Center(child: Text('No data available'));
      }

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Employee',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Dcontroller.refreshdata(),
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                final user = controller.users[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 98,
                          decoration: BoxDecoration(
                            color: user.color1,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: user.iconBgColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            user.icondata,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 15),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(user.email),
                                Text(user.position),
                                Text(user.department),
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
          ],
        ),
      );
    });
  }
}
