import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Loadingui/Loading_Screen.dart';
import '../../../Loadingui/loading_controller.dart';
import '../../Attendance/controllers/attendane_screen_controller.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/controllers/drawer_controller.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../widgets/department_piechart.dart';

class DepartmentScreen extends StatefulWidget {
  static const String routeName = '/DepartmentScreen';

  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen>
    with TickerProviderStateMixin {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final AttendanceScreenController controllers =
  Get.put(AttendanceScreenController());
  bool _showLoginCard = false;
  bool _showLoginCard1 = false;

  String? _error;
  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<AppDrawerController>()) {
      Get.put(AppDrawerController());
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showLoginCard = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showLoginCard1 = true;
      });
    });
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
                    if (isMobile) _buildHeader(),
                    if (!isMobile) Padding(padding: const EdgeInsets.all(8), child: _buildHeader()),
                    const Cardinfo(),
                    // _buildResponsiveContent(),
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
    return Obx(
          () => AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: controllers.showlogincard2.value ? 1.0 : 0.0,
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.only(
            top: controllers.showlogincard2.value ? 0 : 100,
          ),
          child: SizedBox(
            height: 70,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              shadowColor: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        isMobile ? Text(
                          'DEPARTMENT DASHBOARD',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ) : Text(
                          'DEPARTMENT DASHBOARD',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )

                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        isMobile ? TextButton(
                          onPressed: () => controllers.refreshdata(),
                          child: const Text(
                            'Refresh',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ): TextButton(
                          onPressed: () => controllers.refreshdata(),
                          child: const Text(
                            'Refresh',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
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

  // Widget _buildResponsiveContent() {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       final isMobile = constraints.maxWidth < 600;
  //       if (isMobile) {
  //         return _buildMobileContent();
  //       } else {
  //         return _buildDesktopTabletContent();
  //       }
  //     },
  //   );
  // }
  //
  // Widget _buildMobileContent() {
  //   final isMobile = Get.width < 600;
  //   return Padding(
  //     padding:  EdgeInsets.all(8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         if (isMobile)
  //           EmployeefilterView(),
  //         SizedBox(height: 10),
  //         if (isMobile)
  //           SearchbarScreen(),
  //         SizedBox(height: 10),
  //         EmployeeList(),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildDesktopTabletContent() {
  //   return Padding(
  //     padding:  EdgeInsets.all(8.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child:  Scrollbar(
  //         controller: _horizontalScrollController,
  //         thumbVisibility: true,
  //         child: Scrollbar(
  //           controller: _verticalScrollController,
  //           thumbVisibility: true,
  //           child: SingleChildScrollView(
  //             controller: _verticalScrollController,
  //             child: SingleChildScrollView(
  //               controller: _horizontalScrollController,
  //               scrollDirection: Axis.horizontal,
  //               child: ConstrainedBox(
  //                 constraints: BoxConstraints(
  //                   minWidth: MediaQuery.of(context).size.width,
  //                   maxWidth: MediaQuery.of(context).size.width * 1.5,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(12.0),
  //                   child: EmployeeList(),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       )
  //       ,
  //     ),
  //   );
  // }
}
