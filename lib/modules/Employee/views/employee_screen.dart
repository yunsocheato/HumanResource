import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Attendance/views/attendance_filter_view.dart';
import '../../Bottomappbar/widget/bottomappbar_widget.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Employee/widgets/employee_record.dart';
import '../Controller/employee_screen_controller.dart';

class EmployeeScreen extends GetView<EmployeeScreenController> {
   const EmployeeScreen({super.key,});
  static const String routeName = '/employee';

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
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              EneftyIcons.user_bold,
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Stack(
                          children: [
                            Text(
                              'EMPLOYEE',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                foreground:
                                Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.green[700]!,
                              ),
                            ),
                            Text(
                              'EMPLOYEE',
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
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              EneftyIcons.user_bold,
                              color: Colors.green,
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
                        color: Colors.green,
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
       cardWidthFactor = 0.5;
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

     const employeeList = EmployeeList();

     if (isMobile) {
       return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const AttendanceFilterView(),
           const SizedBox(height: 10),
           const EmployeeList(),
         ],
       );
     }

     if (isTablet) {
       return SingleChildScrollView(
         scrollDirection: Axis.horizontal,
         child: Center(
           child: SizedBox(
             width: safeCardWidth,
             height: cardHeight,
             child: Card(
               elevation: 4,
               child: employeeList,
             ),
           ),
         ),
       );
     }

     if (isLaptop || isDesktop) {
       return Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Expanded(child: employeeList),
         ],
       );
     }
     return Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Expanded(child: employeeList),
         const SizedBox(width: 12),
         Expanded(
           child: Card(
             elevation: 2,
             child: Center(child: Text("Extra Space / Future Widget")),
           ),
         ),
       ],
     );
   }

}
