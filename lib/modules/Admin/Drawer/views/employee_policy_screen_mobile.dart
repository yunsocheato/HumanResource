import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Core/user_profile_controller.dart';
import 'package:hrms/Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import 'package:hrms/modules/Admin/Drawer/views/drawer_screen.dart';
import 'package:hrms/modules/AdminDept/widget/bottom_appbar_widget1.dart';
import 'package:hrms/modules/AdminDept/widget/drawer_widget.dart';

import '../../../../Utils/SnackBar/snack_bar.dart';
import '../controllers/employee_policy_controller.dart';

class EmployeePolicyMobile extends GetView<EmployeePolicyController> {
  const EmployeePolicyMobile({super.key});
  static const String routeName = '/user_update_mobile';

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
      final bool isMobile = Get.width < 900;
      if (!isMobile) {
        Future.microtask(() => Get.offAllNamed('/dashboard'));
        return const SizedBox();
      }
      final content = _buildMobileContent();

      return isMobile
          ? (isAdmin
              ? BottomAppBarWidget(body: Drawerscreen(content: content))
              : BottomAppBarWidget1(body: DrawerAdmin(content: content)))
          : content;
    });
  }

  Widget _buildMobileContent() {
    final size = MediaQuery.of(Get.context!).size;

    const double searchHeight = 60;

    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned.fill(
              top: searchHeight + 40,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    12,
                    16,
                    12,
                    kBottomNavigationBarHeight + 24,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeaderBar(),
                        const SizedBox(height: 16),

                        _buildSearchField(controller),
                        const SizedBox(height: 16),

                        Obx(() {
                          if (controller.isLoading.value) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue.shade900,
                              ),
                            );
                          }
                          if (controller.Username.value.isEmpty) {
                            return const Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Not Search Yet',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Column(
                            children: [
                              _buildInformationCard(
                                title: "Basic Information",
                                color: Colors.blue.shade700,
                                fields: _basicFields(controller),
                              ),
                              const SizedBox(height: 16),

                              _buildInformationCard(
                                title: "Contact Information",
                                color: Colors.red.shade700,
                                fields: _contactFields(controller),
                              ),
                              const SizedBox(height: 16),

                              _buildInformationCard(
                                title: "Work Information",
                                color: Colors.orange.shade700,
                                fields: _workFields(controller),
                              ),
                              const SizedBox(height: 24),

                              _buildUpdateButtons(controller),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                controller.clearDataFields();
                controller.suggestionList.clear();
                Get.offAllNamed('/dashboard');
              },
            ),
            const Text(
              "Back",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
        Text(
          "UPDADE USER",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
            fontFamily: '7TH.ttf',
            decoration: TextDecoration.underline,
            decorationThickness: 2,
            decorationColor: Colors.blue.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(EmployeePolicyController controller) {
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
              final query = value.trim();
              if (query.isNotEmpty) {
                controller.fetchbyusersemployee(query);
                controller.usernameSearchController.clear();
                controller.suggestionList.clear();
              }
            },
            decoration: InputDecoration(
              hintText: 'Search by Username',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final query = controller.usernameSearchController.text.trim();
                  if (query.isNotEmpty) {
                    controller.fetchbyusersemployee(query);
                    controller.usernameSearchController.clear();
                    controller.suggestionList.clear();
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) {
              controller.Username.value = v;
              if (v.trim().isNotEmpty) {
                controller.fetchSuggestions(v.trim());
              } else {
                controller.usernameSearchController.clear();
                controller.suggestionList.clear();
              }
            },
          ),
          if (controller.suggestionList.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 6),
              constraints: const BoxConstraints(maxHeight: 150),
              decoration: BoxDecoration(
                color: Colors.white,
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
                      controller.usernameSearchController.text = s;
                      controller.Username.value = s;
                      controller.fetchbyusersemployee(s);
                      controller.usernameSearchController.clear();
                      controller.suggestionList.clear();
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }

  Widget _buildInformationCard({
    required String title,
    required Color color,
    required List<Widget> fields,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 6, height: 22, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...fields,
        ],
      ),
    );
  }

  Widget _field(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green.shade900),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  List<Widget> _basicFields(EmployeePolicyController c) => [
    _field("USER-ID", Icons.verified_user, c.UserIDController),
    _field("USERNAME", Icons.person, c.NameController),
    _field("EMAIL", Icons.email, c.EmailController),
    _field("ROLE", Icons.star, c.RoleController),
    _field("JOIN DATE", Icons.calendar_month, c.createAtController),
  ];

  List<Widget> _contactFields(EmployeePolicyController c) => [
    _field("PHONE", Icons.phone, c.PhoneController),
    _field("ADDRESS", Icons.add_location_alt_outlined, c.AddressController),
  ];

  List<Widget> _workFields(EmployeePolicyController c) => [
    _field("Position", Icons.chair, c.poisitionController),
    _field("DEPARTMENT", Icons.apartment, c.DepartmentController),
    _field("ID CARD", Icons.photo_camera_front_rounded, c.id_cardController),
    _field("FINGER PRINT", Icons.fingerprint, c.fingerprint_idController),
  ];

  Widget _buildUpdateButtons(EmployeePolicyController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            controller.clearDataFields();
            controller.suggestionList.clear();
            Get.offAllNamed('/dashboard');
          },
          child: const Text("Close", style: TextStyle(color: Colors.red)),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade900,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("UPDATE"),
          onPressed: () async {
            await controller.UpdateChange();

            showAwesomeSnackBarGetx(
              "Success",
              "Update UserInfo on: ${controller.NameController.text}",
              ContentType.success,
            );
            controller.clearDataFields();
            controller.suggestionList.clear();
            Get.offAllNamed('/dashboard');
          },
        ),
      ],
    );
  }
}
