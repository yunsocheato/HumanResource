import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/LeaveRequest/widgets/leave_record_widget.dart';
import '../../Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../controllers/apply_leave_screen_controller.dart';

class ApplyLeaveScreen extends GetView<ApplyLeaveScreenController> {
  const ApplyLeaveScreen({super.key});
  static const String routeName = '/ApplyLeave';

  @override
  Widget build(BuildContext context) {
    final loading = Get.find<LoadingUiController>();
    final isMobile = Get.width < 600;

    final contents = Drawerscreen(
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
                    const SizedBox(height: 10),
                    if (isMobile) _buildHeader(),
                    if (!isMobile)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildHeader(),
                      ),
                    const SizedBox(height: 15),
                    _buildResponsiveContent(),
                  ],
                ),
              ),
            ),
            Obx(() => loading.isLoading.value
                ? const LoadingScreen()
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );

    return isMobile
        ? BottomAppBarWidget(body: contents)
        : contents;
  }

  Widget _buildResponsiveContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return isMobile ? _buildMobileContent() : _buildDesktopTabletContent();
      },
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                Boxicons.bx_walk,
                                color: Colors.red,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Stack(
                              children: <Widget>[
                                Text(
                                  'Apply Leave',
                                  style: TextStyle(
                                    fontSize: 16,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.red[700]!,
                                  ),
                                ),
                                const Text(
                                  'Apply Leave',
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
                                  'Apply Leave',
                                  style: TextStyle(
                                    fontSize: 24,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.red[700]!,
                                  ),
                                ),
                                const Text(
                                  'Apply Leave',
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
                    IconButton(
                      onPressed: () => controller.refreshdata(),
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.red,
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

  Widget _buildMobileContent() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: LeaveRecord(),
    );
  }

  Widget _buildDesktopTabletContent() {
    return const LeaveRecord();
  }
}
