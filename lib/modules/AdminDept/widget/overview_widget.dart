import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/widget/overview_card.dart';
import '../controller/overview_controller.dart';
import 'attendance_chart_widget.dart';
import 'attendance_widget.dart';
import 'leave_chart_widget.dart';
import 'leave_record_widget.dart';
import 'overview_card_pageview.dart';
import 'overview_card_sidebar.dart';

class OverViewWidget extends GetView<OverViewController> {
  const OverViewWidget({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final isMobileGlobal = Get.width < 900;
    final padding = EdgeInsets.all(isMobileGlobal ? 16.0 : 32.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isMobile = width < 900;
        final isTablet = width >= 900 && width < 1200;
        final isDesktop = width >= 1200 && width < 1440;
        final isLaptop = width >= 1440;

        const double mobileFontSize = 15.0;
        const double tabletFontSize = 15.0;
        const double desktopFontSize = 20.0;
        const double laptopFontSize = 15.0;

        final double fontSize =
            isMobile
                ? mobileFontSize
                : isTablet
                ? tabletFontSize
                : isDesktop
                ? desktopFontSize
                : isLaptop
                ? laptopFontSize
                : mobileFontSize;

        if (isMobile) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'DASHBOARD',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const Gridoverviewoverview(),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    PageOverviewScreen(),
                    const SizedBox(height: 25),
                    _buildProfileSidebar(),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'LEAVE RECORD',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    LeaveRequestTablewidget(),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ATTENDANCE RECORDS',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    AttendanceTablewidget(),
                  ],
                ),
              ],
            ),
          );
        }

        double maxTableWidth;

        if (width < 1024) {
          maxTableWidth = width * 0.62;
        } else if (width < 1440) {
          maxTableWidth = width * 0.72;
        } else {
          maxTableWidth = width * 0.78;
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            SizedBox(
              width: maxTableWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.grey.shade200,
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.topLeft,
                        child: PageOverviewScreen(),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'DASHBOARD',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      const Gridoverviewoverview(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'LEAVE RECORDS',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      const LeaveRequestTablewidget(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ATTENDANCE RECORDS',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AttendanceTablewidget(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProfileSidebar(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileSidebar() {
    double MobilefontSize = 15.0;
    double LaptopfontSize = 15.0;
    double TabletfontSize = 15.0;
    double DesktopfontSize = 23.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        final bool isMobile = maxWidth < 900;
        final bool isTablet = maxWidth >= 900 && maxWidth < 1200;
        final bool isDesktop = maxWidth >= 1200 && maxWidth < 1440;
        final bool isLaptop = maxWidth >= 1440;

        final double sidebarWidth = isMobile ? maxWidth : 300.0;

        double fontSize =
            isMobile
                ? MobilefontSize
                : isTablet
                ? TabletfontSize
                : isDesktop
                ? DesktopfontSize
                : isLaptop
                ? LaptopfontSize
                : MobilefontSize;

        if (isMobile || isTablet) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LEAVE BALANCE',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Gridoverviewsidebar(),
              const SizedBox(height: 20),
              Text(
                'TEAM MEMBER',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildTeamSidebar1(),
              const SizedBox(height: 20),
              Text(
                'ATTENDANCE COUNTS',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AttendanceChartWidget(),
              const SizedBox(height: 20),
              Text(
                'LEAVE ANALYZES',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              LeaveChartWidget(),
            ],
          );
        }

        return Container(
          width: sidebarWidth,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'LEAVE BALANCE',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Gridoverviewsidebar(),
              const SizedBox(height: 25),
              Text(
                'TEAM MEMBER',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildTeamSidebar1(),
              const SizedBox(height: 25),
              Text(
                'ATTENDANCE COUNTS',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              AttendanceChartWidget(),
              const SizedBox(height: 25),
              Text(
                'LEAVE ANALYZES',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              LeaveChartWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamSidebar1() {
    double MobilefontSize = 13.0;
    double LaptopfontSize = 15.0;
    double TabletfontSize = 15.0;
    double DesktopfontSize = 23.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        final isTablet =
            constraints.maxWidth >= 900 && constraints.maxWidth < 1200;
        final isDesktop =
            constraints.maxWidth >= 1200 && constraints.maxWidth < 1440;
        final isLaptop = constraints.maxWidth >= 1440;
        final sidebarWidth = isMobile ? constraints.maxWidth : 300.0;

        double fontSize =
            isMobile
                ? MobilefontSize
                : isTablet
                ? TabletfontSize
                : isDesktop
                ? DesktopfontSize
                : isLaptop
                ? LaptopfontSize
                : MobilefontSize;
        return Container(
          width: sidebarWidth,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
        );
      },
    );
  }
}
