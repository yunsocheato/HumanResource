import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Bottomappbar/widget/bottomappbar_widget.dart';
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

    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isLaptop = width >= 1024 && width < 1440;
    final isDesktop = width >= 1440 && width < 2560;
    final isLargeDesktop = width >= 2560;

    double cardWidthFactor;
    double cardHeight = 350;

    if (isMobile) {
      cardWidthFactor = 1.0;
      cardHeight = 220;
    } else if (isTablet) {
      cardWidthFactor = 0.38;
      cardHeight = 300;
    } else if (isLaptop) {
      cardWidthFactor = 0.38;
    } else if (isDesktop) {
      cardWidthFactor = 0.25;
    } else {
      cardWidthFactor = 0.2;
    }

    final cardWidth = width * cardWidthFactor;
    final safeCardWidth = cardWidth < 350.0 ? cardWidth : 350.0;

    final cards = [
      ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: cardWidth,
            maxWidth: cardWidth,
            minHeight: cardHeight,
        ),
        child: const AttendanceChart(),
      ),
      const SizedBox(width: 5),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: cardWidth,
          minHeight: cardHeight,
        ),
        child: const AttendacneChartPie(),
      ),
    ];

    final table = SizedBox(
      height: cardHeight,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 300, maxWidth: width),
        child: AttendanceRecords(),
      ),
    );

    if (isMobile || isTablet || isLaptop || isDesktop) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Row(children: cards), const SizedBox(height: 10), table],
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Row(children: cards), const SizedBox(height: 10), table],
        ),
      );
    }
  }
}
