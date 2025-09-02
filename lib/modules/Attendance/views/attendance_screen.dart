import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/controllers/drawer_controller.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../../Searchbar/view/search_bar_screen.dart';
import '../controllers/attendance_widget_controller.dart';
import '../controllers/attendane_screen_controller.dart';
import 'attendance_chart.dart';
import 'attendance_chart_pie.dart';
import 'attendance_filter_view.dart';
import 'attendance_record.dart';

class AttendanceScreen extends GetView<AttendanceScreenController> {
  const AttendanceScreen({super.key});
  static const String routeName = '/AttendanceScreen';

  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 600;
    final loading = Get.find<LoadingUiController>();
    final controllers = Get.find<AttendanceScreenController>();
    return Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Scrollbar(
              controller: controllers.verticalScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: controllers.verticalScrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildHeader(),
                      ),
                    if (!isMobile) _buildHeader(),
                    Cardinfo(),
                    _buildcardinfo(),
                  ],
                ),
              ),
            ),
            if (loading.isLoading.value)
               LoadingScreen(),
          ],
        )),
      );
  }
  Widget _buildcardinfo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;

        if (isMobile) {
          return _buildcardinfoRow();
        } else if (isTablet || isDesktop) {
          return _buildcardinfoColoum();
        }else{
          return _buildcardinfoColoum();

        }
      },
    );
  }

  Widget _buildcardinfoColoum() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Row(
              children: [
                const AttendacneChart(),
                const SizedBox(width: 30),
                const AttendacneChartPie(),
                const SizedBox(width: 30),
              ],
            ),
          ),
          SizedBox(height: 20,),
          _CardinfoColumn()
        ],
      ),
    );
  }

  Widget _CardinfoColumn() {
    final ctx = Get.context ?? Get.overlayContext;
    final controllers = Get.find<AttendanceScreenController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
          child: Scrollbar(
            controller: controllers.horizontalScrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: controllers.horizontalScrollController,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(ctx!).size.width - 100,
                  maxWidth: MediaQuery.of(ctx!).size.width,
                  maxHeight: MediaQuery.of(ctx!).size.height * 0.8,
                ),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: AttendanceFilterView(),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AttendanceRecords(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
      )
    );
}

  Widget _buildcardinfoRow() {
    final recentWidgets = const [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: AttendacneChart(),
      ),
      Padding(
        padding: EdgeInsets.all(10.0),
        child: AttendacneChartPie(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...recentWidgets.map(
              (widget) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: widget,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Attendance Records',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicWidth(
                      child: AttendanceFilterView(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
               SearchbarScreen(),
              const SizedBox(height: 10),
              AttendanceRecords(),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildHeader() {
    final ctx = Get.context ?? Get.overlayContext;
    final isMobile = ctx != null
        ? MediaQuery.of(ctx).size.width < 600
        : Get.width < 600;

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
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 5),
                        isMobile
                            ? Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Boxicons.bx_calendar_check,
                                color: Colors.yellow,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Stack(
                              children: <Widget>[
                                Text(
                                  'ATTENDANCE',
                                  style: TextStyle(
                                    fontSize: 16,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.yellow[700]!,
                                  ),
                                ),
                                const Text(
                                  'ATTENDANCE',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : Row(
                          children: [
                            Stack(
                              children: <Widget>[
                                Text(
                                  'ATTENDANCE DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 24,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.yellow[700]!,
                                  ),
                                ),
                                const Text(
                                  'ATTENDANCE DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 24,
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
                                color: Colors.yellow.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_2_outlined,
                                color: Colors.yellow,
                                size: 24,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => controller.refreshdata(),
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.yellow,
                            size: isMobile ? 16 : 24,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
