import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../../../Utils/Loadingui/Loading_Screen.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../../../../Utils/Searchbar/view/search_bar_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../controller/employee_report_controller2.dart';
import '../utils/ExportExcel2.dart';
import '../widget/employee_Latereport_widget2.dart';

class EmployeeLateScreen extends GetView<EmployeeReportController2> {
  const EmployeeLateScreen({super.key});
  static const String routeName = '/employeelate';
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
                    SizedBox(height: 10),
                    if (isMobile) _buildHeader(),
                    SizedBox(height: 10),
                    if (!isMobile)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: _buildHeader(),
                      ),
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
    return isMobile ? BottomAppBarWidget(body: contents) : contents;
  }

  Widget _buildHeader() {
    final context = Get.context;
    final isMobile = MediaQuery.of(context!).size.width < 600;
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
                        const SizedBox(width: 10),
                        isMobile
                            ? Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.folder_copy,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'LATE REPORT',
                                      style: TextStyle(
                                        fontSize: 16,
                                        foreground:
                                            Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = Colors.orange[700]!,
                                      ),
                                    ),
                                    Text(
                                      'LATE REPORT',
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
                                      'LATE REPORT',
                                      style: TextStyle(
                                        fontSize: 24,
                                        foreground:
                                            Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = Colors.orange[700]!,
                                      ),
                                    ),
                                    Text(
                                      'LATE REPORT',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.folder_copy,
                                    color: Colors.orange,
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
                        isMobile
                            ? IconButton(
                              onPressed: () => controller.refreshData(),
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.orange,
                                size: 16,
                              ),
                            )
                            : IconButton(
                              onPressed: () => controller.refreshData(),
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.orange,
                                size: 24,
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
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade900,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Text(
                        'Employee Late',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton(
                      onPressed: () async {
                        controller.isExporting1.value = true;
                        try {
                          await ExportExcel2();
                          Get.snackbar(
                            'Success',
                            'Excel exported successfully',
                          );
                        } catch (e) {
                          Get.snackbar('Error', 'Export failed: $e');
                        } finally {
                          controller.isExporting1.value = false;
                        }
                      },
                      child: Obx(
                        () => Flexible(
                          flex: 1,
                          child: Center(
                            child: Text(
                              controller.isExporting1.value
                                  ? 'Exporting'
                                  : 'Excel',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 10),
          if (isMobile) SearchbarScreen(),
          SizedBox(height: 10),
          EmployeeScreenLateReport(),
        ],
      ),
    );
  }

  Widget _buildDesktopTabletContent() {
    return EmployeeScreenLateReport();
  }
}
