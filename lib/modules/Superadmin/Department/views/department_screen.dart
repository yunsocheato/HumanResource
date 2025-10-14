import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../../../Utils/Loadingui/Loading_Screen.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../controllers/department_controller.dart';
import '../widgets/department_mutiple_button_widget.dart';

class DepartmentScreen extends GetView<DepartmentScreenController> {
  static const String routeName = '/department';
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loading = Get.find<LoadingUiController>();
    final isMobile = Get.width < 600;

    final contents = Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.loose,
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
                    if (isMobile) _buildHeader(),
                    if (!isMobile)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildHeader(),
                      ),
                    const Cardinfo(),
                    const SizedBox(height: 20),
                    ButtonWidget(),
                  ],
                ),
              ),
            ),
            if (loading.isLoading.value) const LoadingScreen(),
          ],
        ),
      ),
    );
    return isMobile ? BottomAppBarWidget(body: contents) : contents;
  }

  Widget _buildHeader() {
    final ctx = Get.context ?? Get.overlayContext;
    final isMobile =
        ctx != null ? MediaQuery.of(ctx).size.width < 600 : Get.width < 600;
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
                                        foreground:
                                            Paint()
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
                                      'DEPARTMENT',
                                      style: TextStyle(
                                        fontSize: 24,
                                        foreground:
                                            Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = Colors.yellow[700]!,
                                      ),
                                    ),
                                    const Text(
                                      'DEPARTMENT',
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
                            ),
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
                        ),
                      ],
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
}
