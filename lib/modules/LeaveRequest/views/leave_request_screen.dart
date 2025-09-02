import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import '../../Attendance/controllers/attendane_screen_controller.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../controllers/leave_controller.dart';
import '../widgets/leave_request_view.dart';
import '../../Drawer/views/drawer_screen.dart';

class LeaveRequest extends GetView<LeaveController> {
  static const String routeName = '/LeaveRequest';
  const LeaveRequest({super.key});



  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeaveController>();
    final loading = Get.find<LoadingUiController>();
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Scrollbar(
              controller: controller.verticalScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: controller.verticalScrollController,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile)
                      _buildHeader(),
                    if (!isMobile)
                      Padding(padding: const EdgeInsets.all(8), child: _buildHeader()),
                    const Cardinfo(),
                    const SizedBox(height: 10),
                    const leaverequesttable(),
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
    final ctx = Get.context ?? Get.overlayContext;
    final isMobile = ctx != null
        ? MediaQuery
        .of(ctx)
        .size
        .width < 600
        : Get.width < 600;

    return Obx(
          () =>
          AnimatedOpacity(
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
                                    color: Colors.red.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person_2_outlined,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'LEAVE REQUEST',
                                      style: TextStyle(
                                        fontSize: 16,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.red[700]!,
                                      ),
                                    ),
                                    const Text(
                                      'LEAVE REQUEST',
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
                                      'LEAVE REQUEST',
                                      style: TextStyle(
                                        fontSize: 24,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.red[700]!,
                                      ),
                                    ),
                                    const Text(
                                      'LEAVE REQUEST',
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
                                    color: Colors.red.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Boxicons.bx_walk,
                                    color: Colors.red,
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
                                color: Colors.red,
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
