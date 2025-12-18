import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/employee_profile_controller.dart';
import '../views/employee_profile_screen.dart';

class EmployeeProfileWidget extends GetView<EmployeeProfileController> {
  const EmployeeProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EmployeeProfileController>()) {
      Get.put(EmployeeProfileController());
    }
    final isMobile = Get.width < 600;
    return isMobile ? _buildMobile(context) : _buildDesktop(context);
  }

  Widget _buildMobile(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(title: 'Employee Profile', fontSize: 15, height: 30),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      )
                      : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // _buildUsernameAutoSuggestField(),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () => Get.back(),
                            ),
                          ),
                        ],
                      ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDesktop(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(title: 'Employee Profile', fontSize: 18, height: 60),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade900,
                        ),
                      )
                      : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildUsernameAutoSuggestField(controller),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                controller.suggestionList.clear();
                                controller.usernameSearchController.clear();
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader({
    required String title,
    required double fontSize,
    required double height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.settings, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameAutoSuggestField(EmployeeProfileController controller) {
    return Obx(() {
      return Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.search,
            controller: controller.usernameSearchController,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                controller.suggestionList.clear();
                controller.usernameSearchController.clear();
                controller.fetchbyusersemployeeProfile(value);
                Future.microtask(() {
                  controller.suggestionList.clear();
                });
                Get.to(() => EmployeeProfileScreen());
              }
            },
            decoration: InputDecoration(
              hintText: 'Search by Username',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.fetchbyusersemployeeProfile(
                    controller.Username.value,
                  );
                  controller.suggestionList.clear();
                  controller.usernameSearchController.clear();
                  Get.to(() => EmployeeProfileScreen());
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) {
              controller.Username.value = v;
              if (v.isNotEmpty) {
                controller.fetchSuggestionsProfile(v);
              } else {
                controller.suggestionList.clear();
              }
            },
          ),

          if (controller.suggestionList.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 6),
              constraints: const BoxConstraints(maxHeight: 150),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.builder(
                itemCount: controller.suggestionList.length,
                itemBuilder: (_, index) {
                  final s = controller.suggestionList[index];
                  return ListTile(
                    title: Text(s),
                    onTap: () {
                      controller.fetchbyusersemployeeProfile(s);
                      controller.usernameSearchController.clear();
                      Future.microtask(() {
                        controller.suggestionList.clear();
                      });
                      Get.to(() => EmployeeProfileScreen());
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }
}
