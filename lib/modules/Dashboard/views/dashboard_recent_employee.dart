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
    return Card (
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 30,
                width: 145,
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                  )
                ),
                child: Center(
                  child: Text(
                    'Recent Employees',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

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
                  columns: [
                    DataColumn(
                      label: Container(
                        height: 28,
                        width: 70,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: const Text(
                            'Photo',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 28,
                        width: 70,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(5),

                        ),
                        child: Center(
                          child: const Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 28,
                        width: 70,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.yellow[900],
                        ),
                        child: Center(
                          child: const Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 28,
                        width: 70,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: const Text(
                            'Position',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 28,
                        width: 70,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: const Text(
                            'Department',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: controller.users.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: user.photo_url != null && user.photo_url!.isNotEmpty
                                ? NetworkImage(user.photo_url!)
                                : null,
                            child: user.photo_url == null || user.photo_url!.isEmpty
                                ? Icon(Icons.person, color: Colors.grey)
                                : null,
                          ),
                        ),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple.shade700,
                          Colors.deepPurpleAccent.shade100,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Recent Employee',
                        style: TextStyle(fontSize: 16,color: Colors.white ,fontWeight: FontWeight.bold),
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
                          child:  CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: user.photo_url != null && user.photo_url!.isNotEmpty
                                ? NetworkImage(user.photo_url!)
                                : null,
                            child: user.photo_url == null || user.photo_url!.isEmpty
                                ? Icon(Icons.person, color: Colors.grey)
                                : null,
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
