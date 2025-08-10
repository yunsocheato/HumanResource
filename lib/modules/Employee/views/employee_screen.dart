import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Dashboard/controllers/dashboard_screen_controller.dart';
import '../../Attendance/controllers/attendance_widget_controller.dart';
import '../../Attendance/controllers/attendane_screen_controller.dart';
import '../../Attendance/views/attendance_record.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Employee/views/employee_filter_view.dart';
import '../../Employee/widgets/employee_record.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../../Searchbar/view/search_bar_screen.dart';

class EmployeeScreen extends StatefulWidget {
  static const String routeName = '/EmloyeeScreen';
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final DashboardController controller = Get.put(DashboardController());
  final AttendanceController attendanceController = Get.put(AttendanceController());
  bool _showHeader = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showHeader = true;
      });
    });
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = Get.find<LoadingUiController>();
    final isMobile = Get.width < 600;

    return Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Scrollbar(
              controller: _verticalScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    if (isMobile) _buildHeader(),
                    SizedBox(height: 10),
                    if (!isMobile) Padding(padding: const EdgeInsets.all(8), child: _buildHeader()),
                    SizedBox(height: 15),
                    const Cardinfo(),
                    SizedBox(height: 15),
                    _buildResponsiveContent(),
                  ],
                ),
              ),
            ),
            if (loading.isLoading.value) const LoadingScreen(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Obx(() => AnimatedOpacity(
      duration: const Duration(seconds: 2),
      opacity: controller.showlogincard1.value ? 1.0 : 0.0,
      child: AnimatedPadding(
        duration: const Duration(seconds: 2),
        padding: EdgeInsets.only(
          top: controller.showlogincard1.value ? 0 : 100,
        ),
        child: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20),
                    isMobile ? Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                                Icons.person_2_outlined, color: Colors.green,
                                size: 16)),
                        SizedBox(width: 10,),
                        Stack(
                          children: <Widget>[
                            Text(
                              'EMPLOYEE\nDASHBOARD',
                              style: TextStyle(
                                fontSize: 16,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.green[700]!,
                              ),
                            ),
                            Text(
                              'EMPLOYEE\nDASHBOARD',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ) :
                    Row(
                      children: [
                        Stack(
                          children: <Widget>[
                            Text(
                              'EMPLOYEE DASHBOARD',
                              style: TextStyle(
                                fontSize: 24,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.green[700]!,
                              ),
                            ),
                            Text(
                              'EMPLOYEE DASHBOARD',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person_2_outlined, color: Colors.green, size: 24)),
                      ],
                    )

                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    isMobile ? IconButton(onPressed: () => controller.refreshdata()
                        , icon: Icon(Icons.refresh, color: Colors.green, size: 16,)
                    ):
                    IconButton(onPressed: () => controller.refreshdata()
                        , icon: Icon(Icons.refresh, color: Colors.green, size: 24,)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildResponsiveContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        if (isMobile) {
          return _buildMobileContent();
        } else {
          return _buildDesktopTabletContent();
        }
      },
    );
  }

  Widget _buildMobileContent() {
    final isMobile = Get.width < 600;
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
           EmployeefilterView(),
           SizedBox(height: 10),
           if (isMobile)
           SearchbarScreen(),
           SizedBox(height: 10),
           EmployeeList(),
        ],
      ),
    );
  }

  Widget _buildDesktopTabletContent() {
    return EmployeeList();
  }
}
