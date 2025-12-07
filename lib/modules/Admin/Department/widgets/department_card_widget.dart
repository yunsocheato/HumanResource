import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../controllers/department_controller.dart';
import '../models/department_model.dart';

class DepartmentCard extends GetView<DepartmentScreenController> {
  const DepartmentCard({super.key});

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

    return Column(
      children: [
        const SizedBox(height: 5),
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
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.5,
              ),
              itemCount: user.length,
              itemBuilder: (context, index) {
                final userData = user[index];
                return MouseHover(
                  keyId: 8,
                  controller: controller1,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const VerticalDivider(
                            width: 1,
                            thickness: 3,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/profileuser.png',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                userData.Name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Center(
                                child: Text(
                                  'in',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${userData.Department} Department',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget DesktopScreenContents() {
    final HoverMouseController controller1 = Get.put(HoverMouseController());

    return SizedBox(
      height: Get.height * 0.5,
      width: double.infinity,
      child: Card(
        elevation: 10,
        color: Colors.white,
        shadowColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: FutureBuilder<List<DepartmentModel>>(
                future: controller.departmentSQL.getUsersByDepartment(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 300),
                        tween: Tween(begin: 0, end: controller.progress.value),
                        builder: (context, value, _) {
                          return SizedBox(
                            width: 700,
                            height: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 8,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                backgroundColor: Colors.blue,
                                semanticsLabel: 'Loading...',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final users = snapshot.data!;
                  final cardWidth = Get.width / 4 - 16;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return MouseHover(
                        keyId: 8,
                        controller: controller1,
                        child: Center(
                          child: SizedBox(
                            width: cardWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const VerticalDivider(
                                        width: 1,
                                        thickness: 2,
                                        color: Colors.red,
                                      ),

                                      const SizedBox(width: 20),
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.blue,
                                        child: Image(
                                          image: AssetImage(
                                            'assets/images/profileuser.png',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              user.Name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              'in',
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Flexible(
                                              child: Text(
                                                user.Department,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
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
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
