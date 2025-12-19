import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:hrms/Utils/Loadingui/Loading_skeleton.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
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
            padding: const EdgeInsets.all(8),
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return SizedBox(
                width: cardWidth,
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
                              user.photo_url == null || user.photo_url!.isEmpty
                                  ? const Icon(Icons.person, color: Colors.grey)
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
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildTabletDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double fontSize(double base) {
      if (width >= 1600) return base * 1.3;
      if (width >= 1200) return base * 1.3;
      if (width >= 1000) return base * 5.6;
      return base * 0.9;
    }

    double colWidth(double base) {
      if (width >= 1600) return base * 1.5;
      if (width >= 1200) return base * 1.3;
      if (width >= 1000) return base * 5.6;
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'Register Employee',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontFamily: '7TH.ttf',
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => showRegisterUsersDialog(),
                    icon: Icon(Icons.fullscreen, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AttendanceFilterView(),
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

                              final register = controller.users;

                              if (register.isEmpty) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Not Found Register User ',
                                        style: TextStyle(
                                          fontSize: fontSize(15),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Image.asset(
                                        'assets/icon/nodata.png',
                                        width: fontSize(120),
                                        height: fontSize(120),
                                      ),
                                    ],
                                  ),
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
                                dataTextStyle: TextStyle(
                                  fontSize: fontSize(13),
                                ),
                                columns: [
                                  _coloredColumn(
                                    'Image',
                                    Colors.blue,
                                    colWidth(59),
                                    fontSize,
                                  ),
                                  _coloredColumn(
                                    'Name',
                                    Colors.green,
                                    colWidth(59),
                                    fontSize,
                                  ),
                                  _coloredColumn(
                                    'Email',
                                    Colors.orange,
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
                                    'Department',
                                    Colors.redAccent,
                                    colWidth(59),
                                    fontSize,
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
                                                          user
                                                              .photo_url!
                                                              .isNotEmpty
                                                      ? NetworkImage(
                                                        user.photo_url!,
                                                      )
                                                      : null,
                                              child:
                                                  user.photo_url == null ||
                                                          user
                                                              .photo_url!
                                                              .isEmpty
                                                      ? const Icon(
                                                        Icons.person,
                                                        color: Colors.grey,
                                                      )
                                                      : null,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.name,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.email,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.position,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.department,
                                              style: TextStyle(fontSize: 13),
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

  void showRegisterUsersDialog() {
    final width = MediaQuery.of(Get.context!).size.width;
    double fontSize(double base) {
      if (width >= 1600) return base * 1.3;
      if (width >= 1200) return base * 1.3;
      if (width >= 1000) return base * 5.6;
      return base * 0.9;
    }

    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        'Register Employee',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontFamily: '7TH.ttf',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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

                                  final register = controller.users;

                                  if (register.isEmpty) {
                                    return Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Not Found Register User',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
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
                                  return DataTable(
                                    dataRowHeight: 45,
                                    columnSpacing: 20,
                                    headingTextStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    columns: [
                                      _coloredColumn(
                                        'Image',
                                        Colors.blue,
                                        59,
                                        fontSize,
                                      ),
                                      _coloredColumn(
                                        'Name',
                                        Colors.green,
                                        100,
                                        fontSize,
                                      ),
                                      _coloredColumn(
                                        'Email',
                                        Colors.orange,
                                        150,
                                        fontSize,
                                      ),
                                      _coloredColumn(
                                        'Position',
                                        Colors.green,
                                        100,
                                        fontSize,
                                      ),
                                      _coloredColumn(
                                        'Department',
                                        Colors.redAccent,
                                        100,
                                        fontSize,
                                      ),
                                    ],
                                    rows:
                                        register.map((user) {
                                          return DataRow(
                                            cells: [
                                              DataCell(
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  backgroundImage:
                                                      user.photo_url != null &&
                                                              user
                                                                  .photo_url!
                                                                  .isNotEmpty
                                                          ? NetworkImage(
                                                            user.photo_url!,
                                                          )
                                                          : null,
                                                  child:
                                                      user.photo_url == null ||
                                                              user
                                                                  .photo_url!
                                                                  .isEmpty
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
        ),
      ),
      barrierDismissible: false,
    );
  }
}
