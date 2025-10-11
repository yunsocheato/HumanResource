import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../../Attendance/views/attendance_filter_view.dart';
import '../controllers/dashboard_recently_screen_controller.dart';

class Recentemployee extends GetView<RecentlyControllerScreen> {
  const Recentemployee({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isDesktop = width >= 1024;
        final isLaptop = width >= 1440 && width < 2560;
        final isLargeDesktop = width >= 2560;

        double cardHeight;
        double titleFontSize;
        double cardWidth;

        if (isMobile) {
          cardHeight = 150;
          titleFontSize = 12;
          cardWidth = double.infinity;
        } else if (isTablet) {
          cardHeight = 260;
          titleFontSize = 13;
          cardWidth = width * 0.3;
        } else if (isLaptop) {
          cardHeight = 300;
          titleFontSize = 14;
          cardWidth = double.infinity;
        } else if (isDesktop) {
          cardHeight = 270;
          titleFontSize = 16;
          cardWidth = double.infinity;
        } else if (isLargeDesktop) {
          cardHeight = 280;
          titleFontSize = 17;
          cardWidth = double.infinity;
        } else {
          cardHeight = 320;
          titleFontSize = 22;
          cardWidth = double.infinity;
        }
        if (isMobile) {
          return _buildMobile(context, cardHeight, titleFontSize, cardWidth);
        } else {
          return _buildTabletDesktop(context);
        }
      },
    );
  }

  Widget _buildMobile(
    BuildContext context,
    double cardHeight,
    double titleFontSize,
    double cardWidth,
  ) {
    final controller = Get.find<RecentlyControllerScreen>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.users.isEmpty) {
        return const Center(child: Text('No data available'));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 30,
              width: 145,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.redAccent.shade700,
                    Colors.redAccent.shade100,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Register Employees',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: cardWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: cardHeight,
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
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[200],
                              backgroundImage:
                                  user.photo_url != null &&
                                          user.photo_url!.isNotEmpty
                                      ? NetworkImage(user.photo_url!)
                                      : null,
                              child:
                                  user.photo_url == null ||
                                          user.photo_url!.isEmpty
                                      ? const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      )
                                      : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildTabletDesktop(BuildContext context) {
    final controller = Get.find<RecentlyControllerScreen>();
    final HoverMouseController controller1 = Get.put(HoverMouseController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.users.isEmpty) {
        return const Center(child: Text('No data available'));
      }

      return MouseHover(
        keyId: 4,
        controller: controller1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 145,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.redAccent.shade700,
                          Colors.redAccent.shade100,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Register Employees",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AttendanceFilterView(),
                  ),
                  const SizedBox(height: 5),

                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width - 350,
                        ),
                        child: DataTable(
                          columns: [
                            DataColumn(
                              label: Container(
                                height: 40,
                                width: 80,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Photo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                height: 40,
                                width: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                height: 40,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade900,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Email',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                height: 40,
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade900,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Position',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                height: 40,
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade900,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Department',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          rows:
                              controller.users.map((user) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey[200],
                                        backgroundImage:
                                            user.photo_url != null &&
                                                    user.photo_url!.isNotEmpty
                                                ? NetworkImage(user.photo_url!)
                                                : null,
                                        child:
                                            user.photo_url == null ||
                                                    user.photo_url!.isEmpty
                                                ? const Icon(
                                                  Icons.person,
                                                  color: Colors.grey,
                                                )
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
