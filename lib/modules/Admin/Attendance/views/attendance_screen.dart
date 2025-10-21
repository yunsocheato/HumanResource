import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../controllers/attendane_screen_controller.dart';
import 'attendance_chart.dart';
import 'attendance_chart_pie.dart';
import 'attendance_record.dart';

class AttendanceScreen extends GetView<AttendanceScreenController> {
  const AttendanceScreen({super.key});

  static const String routeName = '/attendance';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    final contents = Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildHeader(context, _getTitleFontSize(width)),
              ),
              const SizedBox(height: 10),
              const Cardinfo(),
              const SizedBox(height: 10),
              _buildResponsiveCardInfo(context, width),
            ],
          ),
        ),
      ),
    );
    return isMobile ? BottomAppBarWidget(body: contents) : contents;
  }

  double _getTitleFontSize(double width) {
    if (width < 600) return 14;
    if (width < 1024) return 18;
    if (width < 1440) return 20;
    if (width < 2560) return 24;
    return 28;
  }

  Widget _buildHeader(BuildContext context, double titleFontSize) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

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
                      children: [
                        if (isMobile) ...[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              EneftyIcons.clock_2_outline,
                              color: Colors.yellow,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Stack(
                          children: [
                            Text(
                              'ATTENDANCE',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                foreground:
                                    Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.yellow[700]!,
                              ),
                            ),
                            Text(
                              'ATTENDANCE',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        if (!isMobile) ...[
                          const SizedBox(width: 10),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              EneftyIcons.clock_2_outline,
                              color: Colors.yellow,
                              size: 24,
                            ),
                          ),
                        ],
                      ],
                    ),
                    IconButton(
                      onPressed: () => controller.refreshdata(),
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.yellow,
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

  Widget _buildResponsiveCardInfo(BuildContext context, double width) {
    final isMobile = width < 900;
    const double chartMinHeight = 350.0;
    final table = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 600),
        child: AttendanceRecords(),
      ),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 250, maxHeight: 350),
            child: const AttendanceChart(),
          ),
          const SizedBox(height: 10),

          AspectRatio(
            aspectRatio: 1.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 250),
              child: const AttendanceChartPie(),
            ),
          ),

          const SizedBox(height: 10),
          table,
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: AspectRatio(aspectRatio: 1.45, child: AttendanceChart()),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: AspectRatio(
                aspectRatio: 1.45,
                child: AttendanceChartPie(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        table,
      ],
    );
  }
}
