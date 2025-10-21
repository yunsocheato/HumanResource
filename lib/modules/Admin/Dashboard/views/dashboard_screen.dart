import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final contents = Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body:
            isMobile
                ? RefreshIndicator(
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
                )
                : SingleChildScrollView(
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

    return isMobile ? BottomAppBarWidget(body: contents) : contents;
  }

  Widget _buildHeader(BuildContext context, double titleFontSize) {
    final controller = Get.find<DashboardController>();
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Obx(
      () => AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: controller.showlogincard1.value ? 1.0 : 0.0,
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.only(
            top: controller.showlogincard1.value ? 0 : 100,
          ),
          child: SizedBox(
            height: 70,
            child: Card(
              color: Colors.white,
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          isMobile
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
                                            foreground:
                                                Paint()
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
                                ),
                              ]
                              : [
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'DASHBOARD',
                                      style: TextStyle(
                                        fontSize: titleFontSize,
                                        foreground:
                                            Paint()
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;
    final isLaptop = width >= 900 && width < 1440;
    final isTablet = width >= 600 && width < 900;
    final isLargeScreen = width >= 1440;

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 250, maxHeight: 350),
            child: AttendanceChart(),
          ),
          SizedBox(height: 12),
          Recentscreen2(),
          SizedBox(height: 12),
          Recentscreen3(),
          SizedBox(height: 20),
          Recentemployee(),
        ],
      );
    }
    if (isLargeScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                flex: 5,
                child: AspectRatio(aspectRatio: 1.75, child: AttendanceChart()),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: AspectRatio(aspectRatio: 1.45, child: Recentscreen2()),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: AspectRatio(aspectRatio: 1.45, child: Recentscreen3()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Recentemployee(),
        ],
      );
    }

    if (isTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 350),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(child: AttendanceChart()),
                SizedBox(width: 10),
                Expanded(child: Recentscreen2()),
                SizedBox(width: 10),
                Expanded(child: Recentscreen3()),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Recentemployee(),
        ],
      );
    }

    if (isLaptop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(
                  flex: 6,
                  child: AspectRatio(
                    aspectRatio: 1.75,
                    child: AttendanceChart(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: AspectRatio(aspectRatio: 1.45, child: Recentscreen2()),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: AspectRatio(aspectRatio: 1.45, child: Recentscreen3()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Recentemployee(),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
