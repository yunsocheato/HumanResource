import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Core/user_profile_controller.dart';
import 'package:hrms/modules/AdminDept/widget/bottom_appbar_widget1.dart';
import 'package:hrms/modules/AdminDept/widget/drawer_widget.dart';
import '../../../../Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../../../Utils/Searchbar/view/search_bar_screen.dart';
import '../../../../Utils/SnackBar/snack_bar.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../controller/employee_report_controller2.dart';
import '../utils/ExportExcel2.dart';
import '../widget/employee_Latereport_widget2.dart';

class EmployeeLateScreen extends GetView<EmployeeReportController2> {
  const EmployeeLateScreen({super.key});
  static const String routeName = '/employeelate';

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<UserProfileController>();

    return Obx(() {
      final profile = profileController.userprofiles.value;
      if (profile == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final role = profile.role.toLowerCase();
      final bool isAdmin = role == 'admin' || role == 'superadmin';
      final bool isMobile = Get.width < 600;

      final desktopBody = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildHeader(context, _getTitleFontSize(Get.width)),
            ),
            const SizedBox(height: 10),
            _buildDesktopTabletContent(context, Get.width),
          ],
        ),
      );

      final mobileBody = _buildMobileStyleBody();

      final content =
          isAdmin
              ? Drawerscreen(content: isMobile ? mobileBody : desktopBody)
              : DrawerAdmin(content: isMobile ? mobileBody : desktopBody);

      if (isMobile) {
        return isAdmin
            ? BottomAppBarWidget(body: content)
            : BottomAppBarWidget1(body: content);
      }

      return content;
    });
  }

  double _getTitleFontSize(double width) {
    if (width < 600) return 14;
    if (width < 1024) return 18;
    if (width < 1440) return 20;
    if (width < 2560) return 24;
    return 28;
  }

  Widget _buildHeader(BuildContext context, double titleFontSize) {
    final controller = Get.find<EmployeeReportController2>();
    final width = MediaQuery.of(context).size.width;
    final isLaptop = width >= 900 && width < 1440;
    final isDesktop = width >= 1440 && width < 1920;
    final isLargeDesktop = width >= 1920;
    final showHeader = isLaptop || isDesktop || isLargeDesktop;

    return Obx(
      () => AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: controller.showlogincard1.value ? 1.0 : 0.0,
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.only(
            top: controller.showlogincard1.value ? 0 : 100,
          ),
          child:
              showHeader
                  ? SizedBox(
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
                            Stack(
                              children: <Widget>[
                                Text(
                                  'LATE-REPORT',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    foreground:
                                        Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.deepOrange[700]!,
                                  ),
                                ),
                                Text(
                                  'LATE-REPORT',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.offAllNamed('/dashboard');
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.folder,
                                    color: Colors.deepOrange,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'LATE-REPORT',
                                      style: TextStyle(
                                        fontSize: titleFontSize,
                                        foreground:
                                            Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = Colors.deepOrange[700]!,
                                      ),
                                    ),
                                    Text(
                                      'LATE-REPORT',
                                      style: TextStyle(
                                        fontSize: titleFontSize,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildMobileStyleBody() {
    final size = MediaQuery.of(Get.context!).size;
    final bottomBarHeight = kBottomNavigationBarHeight;
    final width = size.width;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade900, Colors.blue.shade700],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height * 0.83,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white38),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(12, 12, 12, bottomBarHeight + 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(Get.context!, _getTitleFontSize(width)),
                    const SearchbarScreen(),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.red.shade900,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final picked = await showDatePicker(
                                    context: Get.context!,
                                    initialDate: controller.startDate.value,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    controller.updateStartDate(picked);
                                  }
                                },
                                child: Text(
                                  'StartDate',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade900,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final picked = await showDatePicker(
                                    context: Get.context!,
                                    initialDate: controller.endDate.value,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    controller.updateEndDate(picked);
                                  }
                                },
                                child: Text(
                                  'EndDate',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(56, 142, 60, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  controller.isExporting1.value = true;
                                  try {
                                    await ExportExcel2();
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          showAwesomeSnackBarGetx(
                                            "Export Success",
                                            "File Excel Export Success",
                                            ContentType.success,
                                          );
                                        });
                                  } catch (e) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          showAwesomeSnackBarGetx(
                                            "Export Failded",
                                            "File Failed to Export",
                                            ContentType.failure,
                                          );
                                        });
                                  } finally {
                                    controller.isExporting1.value = false;
                                  }
                                },
                                child: Obx(
                                  () => Center(
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
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 40,
                          width: 190,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.centerLeft,
                          child: Center(
                            child: Text(
                              '${controller.startDate.value?.toLocal().toString().split(' ')[0]} '
                              'To '
                              '${controller.endDate.value?.toLocal().toString().split(' ')[0]}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const EmployeeScreenLateReport(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -30,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTabletContent(BuildContext context, double width) {
    return EmployeeScreenLateReport();
  }
}
