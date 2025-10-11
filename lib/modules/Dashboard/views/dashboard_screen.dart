import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Attendance/views/attendance_chart.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../controllers/dashboard_screen_controller.dart';
import 'dashboard_recent_employee.dart';
import 'dashboard_recently_screen2.dart';
import 'dashboard_recently_screen3.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});
  static const String routeName = '/dashboard';


  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery
        .of(context)
        .size
        .width < 600;
    final contents = Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: isMobile ? RefreshIndicator(
          onRefresh: () async {
            controller.refreshdata();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildHeader(context, isMobile ? 14 : 24),
                ),
                const SizedBox(height: 10),
                Cardinfo(),
                const SizedBox(height: 10),
                _buildResponsiveCardInfo(context),
              ],
            ),
          ),
        ) : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildHeader(context, isMobile ? 14 : 24),
              ),
              const SizedBox(height: 10),
              Cardinfo(),
              const SizedBox(height: 10),
              _buildResponsiveCardInfo(context),
            ],
          ),
        ),
      ),
    );

    return isMobile
        ? BottomAppBarWidget(body: contents)
        : contents;
  }
  Widget _buildHeader(BuildContext context, double titleFontSize) {
    final controller = Get.find<DashboardController>();
    final isMobile = MediaQuery
        .of(context)
        .size
        .width < 600;

    return Obx(
          () =>
          AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: controller.showlogincard1.value ? 1.0 : 0.0,
            child: AnimatedPadding(
              duration: const Duration(seconds: 2),
              padding: EdgeInsets.only(
                  top: controller.showlogincard1.value ? 0 : 100),
              child: SizedBox(
                height: 70,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: isMobile
                              ? [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.home_outlined,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'DASHBOARD',
                                      style: TextStyle(
                                        fontSize: titleFontSize,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.blue[700]!,
                                      ),
                                    ),
                                    Text(
                                      'DASHBOARD',
                                      style: TextStyle(
                                        fontSize: titleFontSize,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ]
                              : [
                            Stack(
                              children: <Widget>[
                                Text(
                                  'DASHBOARD',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.blue[700]!,
                                  ),
                                ),
                                Text(
                                  'DASHBOARD',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.home_outlined,
                                color: Colors.blue,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => controller.refreshdata(),
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.blue,
                            size: isMobile ? 16 : 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildResponsiveCardInfo(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isLaptop = width >= 1024 && width < 1440;
    final isDesktop = width >= 1440 && width < 2560;
    final isLargeDesktop = width >= 2560;

    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final maxHeight = constraints.maxHeight;

      if (isMobile) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            AttendanceChart(),
            SizedBox(height: 12),
            Recentscreen2(),
            SizedBox(height: 12),
            Recentscreen3(),
            SizedBox(height: 20),
            Recentemployee(),
          ],
        );
      }

      double minCardWidth = 235;
      double minCardHeight = 350;
      double widthFactor;
      double heightFactor = 0.4;

      if (isTablet) {
        widthFactor = 0.7;
      } else if (isLaptop) {
        widthFactor = 0.6;
      } else if (isDesktop) {
        widthFactor = 0.89;
      } else {
        widthFactor = 0.9;
      }

      final maxCardWidth = maxWidth * widthFactor;
      final maxCardHeight = maxHeight * heightFactor;

      final cardWidgets = [
        ConstrainedBox(
          constraints: controller.safeConstraints(
            minW: minCardWidth,
            maxW: maxCardWidth,
            minH: minCardHeight,
            maxH: maxCardHeight,
          ),
          child: const AttendanceChart(),
        ),
        const SizedBox(width: 5),
        ConstrainedBox(
          constraints: controller.safeConstraints(
            minW: minCardWidth,
            maxW: maxCardWidth,
            minH: minCardHeight,
            maxH: maxCardHeight,
          ),
          child: const Recentscreen2(),
        ),
        const SizedBox(width: 5),
        ConstrainedBox(
          constraints: controller.safeConstraints(
            minW: minCardWidth,
            maxW: maxCardWidth,
            minH: minCardHeight,
            maxH: maxCardHeight,
          ),
          child: const Recentscreen3(),
        ),
      ];

      if (isTablet || isLaptop ) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: cardWidgets),
              const SizedBox(height: 10),
              const Recentemployee(),
            ],

          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: cardWidgets),
            const SizedBox(height: 10),
            const Recentemployee(),
          ],
        );
      }
    });
  }
}
