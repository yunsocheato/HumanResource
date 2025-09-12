import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/modules/Department/controllers/department_controller.dart';
import '../../Attendance/controllers/attendane_screen_controller.dart';
import '../../Bottomappbar/widget/bottomappbar_widget.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/controllers/drawer_controller.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';

class DepartmentScreen extends GetView<DepartmentScreenController> {
  static const String routeName = '/DepartmentScreen';

  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loading = Get.find<LoadingUiController>();
    final controllers = Get.find<DepartmentScreenController>();
    final isMobile = Get.width < 600;

    final contents = Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Scrollbar(
              controller: controllers.verticalScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: controllers.verticalScrollController,
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
    return isMobile
        ? BottomAppBarWidget(body: contents)
        : contents;
  }


  Widget _buildHeader() {
    final ctx = Get.context ?? Get.overlayContext;
    final controller = Get.find<DepartmentScreenController>();
    final isMobile = ctx != null ? MediaQuery.of(ctx).size.width < 600 : Get.width < 600;
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
                                Boxicons.bxs_buildings,
                                color: Colors.yellow,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Stack(
                              children: <Widget>[
                                Text(
                                  'DEPARTMENT',
                                  style: TextStyle(
                                    fontSize: 16,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.yellow[700]!,
                                  ),
                                ),
                                const Text(
                                  'DEPARTMENT',
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
                                  'DEPARTMENT DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 24,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.yellow[700]!,
                                  ),
                                ),
                                const Text(
                                  'DEPARTMENT DASHBOARD',
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
                                Boxicons.bxs_buildings,
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
