import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../controllers/apply_leave_screen_controller.dart';
import '../widgets/RequestLeaveWidget.dart';

class ApplyLeaveScreen extends GetView<ApplyLeaveScreenController> {
  const ApplyLeaveScreen({super.key});
  static const String routeName = '/applyleave';

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

  Widget _buildMobileContent() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: RequestLeaveFormWidget(),
    );
  }

  Widget _buildDesktopTabletContent() {
    return const RequestLeaveFormWidget();
  }
}
