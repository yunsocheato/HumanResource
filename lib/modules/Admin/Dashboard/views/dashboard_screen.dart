import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/user_profile_controller.dart';
import '../../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../../AdminDept/controller/overview_controller.dart';
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
                  child: _buildResponsiveBody(context),
                  // child: SingleChildScrollView(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: _buildHeader(context, isMobile ? 14 : 24),
                  //       ),
                  //       const SizedBox(height: 10),
                  //       Cardinfo(),
                  //       const SizedBox(height: 10),
                  //       _buildResponsiveCardInfo(context),
                  //     ],
                  //   ),
                  // ),
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
                      _buildResponsiveBody(context),
                    ],
                  ),
                ),
      ),
    );

    return isMobile ? BottomAppBarWidget(body: contents) : contents;
  }

  Widget _buildHeader(BuildContext context, double titleFontSize) {
    final controller = Get.find<DashboardController>();
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isLaptop = width >= 900 && width < 1440;
    final isDesktop = width >= 1440 && width < 1920;
    final isLargeDesktop = width >= 1920;
    final showHeader = isLaptop || isDesktop || isLargeDesktop;

    return Obx(
      () => AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: controller.showlogincard1.value ? 1.0 : 0.0,
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.only(
            top: controller.showlogincard1.value ? 0 : 100,
          ),
          child:
              showHeader
                  ? SizedBox(
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
                            Stack(
                              children: <Widget>[
                                Text(
                                  'ADMIN DASHBOARD',
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
                                  'ADMIN DASHBOARD',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () => controller.refreshdata(),
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.home,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'ADMIN DASHBOARD',
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
                                      'ADMIN DASHBOARD',
                                      style: TextStyle(
                                        fontSize: titleFontSize,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
    );
  }

  Widget _buildResponsiveBody(BuildContext context) {
    final profileController = Get.find<UserProfileController>();
    final profile = profileController.userprofiles.value;

    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final role = profile.role.toLowerCase();
    final bool isAdmin = role == 'admin' || role == 'superadmin';

    final size = MediaQuery.of(Get.context!).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 900;
    final isMobileOrTablet = isMobile || isTablet;
    final isLaptop = size.width >= 900 && size.width < 1440;
    final isLargeScreen = size.width >= 1440;
    final bottomBarHeight = kBottomNavigationBarHeight;

    if (isMobileOrTablet) {
      return SizedBox(
        height: size.height,
        width: size.width,
        child: ClipRect(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade900, Colors.blue.shade300],
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: size.height * 0.85,
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Positioned.fill(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 12,
                              left: 12,
                              right: 12,
                              bottom: bottomBarHeight,
                            ),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHeader(context, isMobile ? 18 : 24),
                                  SizedBox(height: 10),
                                  Cardinfo(),
                                  const SizedBox(height: 12),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 250,
                                      maxHeight: 350,
                                    ),
                                    child: const AttendanceChart(),
                                  ),
                                  const SizedBox(height: 12),
                                  const Recentscreen2(),
                                  const SizedBox(height: 12),
                                  const Recentscreen3(),
                                  const SizedBox(height: 20),
                                  const Recentemployee(),
                                  SizedBox(height: bottomBarHeight + 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // child: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12),
                  //   child: SingleChildScrollView(
                  //     physics: const AlwaysScrollableScrollPhysics(),
                  //
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         // _buildHeader(context, isMobileOrTablet ? 14 : 24),
                  //         const SizedBox(height: 10),
                  //         Cardinfo(),
                  //         const SizedBox(height: 12),
                  //         const AttendanceChart(),
                  //         const SizedBox(height: 12),
                  //         const Recentscreen2(),
                  //         const SizedBox(height: 12),
                  //         const Recentscreen3(),
                  //         const SizedBox(height: 20),
                  //         const Recentemployee(),
                  //         SizedBox(height: bottomBarHeight + 20),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              Positioned(
                top: -30,
                right: -60,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
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
          SizedBox(width: double.infinity, child: Recentemployee()),
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
          SizedBox(width: double.infinity, child: Recentemployee()),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
