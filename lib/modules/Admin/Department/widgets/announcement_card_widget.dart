import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../../../../Utils/Loadingui/Loading_Screen.dart';
import '../controllers/department_controller.dart';
import '../models/department_model.dart';

class AnnounceMentCard extends GetView<DepartmentScreenController> {
  const AnnounceMentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreenContents();
  }

  Widget ResponsiveScreenContents() {
    final isMobile = Get.width < 600;
    return isMobile ? MobileScreenContents() : DesktopScreenContents();
  }

  Widget MobileScreenContents() {
    final HoverMouseController controller1 = Get.put(HoverMouseController());

    return SizedBox(
      height: Get.height * 0.5,
      width: double.infinity,
      child: MouseHover(
        keyId: 7,
        controller: controller1,
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: Column(
            children: [
              FutureBuilder<List<DepartmentModel>>(
                future: controller.departmentSQL.getUsersByDepartment(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween(begin: 0, end: controller.progress.value),
                      builder: (context, value, _) {
                        return LinearProgressIndicator(
                          value: value,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          backgroundColor: Colors.blue,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final user = snapshot.data!;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: user.length,
                    itemBuilder: (context, index) {
                      final userData = user[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData.Name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userData.Department,
                              style: const TextStyle(fontSize: 10),
                            ),
                            Text(
                              userData.Positon,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget DesktopScreenContents() {
    final HoverMouseController controller1 = Get.put(HoverMouseController());
    return SizedBox(
      height: Get.height * 0.5,
      width: double.infinity,
      child: MouseHover(
        keyId: 7,
        controller: controller1,
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: Column(
            children: [
              FutureBuilder<List<DepartmentModel>>(
                future: controller.departmentSQL.getUsersByDepartment(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingScreen();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final user = snapshot.data!;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: user.length,
                    itemBuilder: (context, index) {
                      final userData = user[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData.Name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userData.Department,
                              style: const TextStyle(fontSize: 10),
                            ),
                            Text(
                              userData.Positon,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
