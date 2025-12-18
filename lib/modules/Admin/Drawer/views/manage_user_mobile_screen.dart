import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hrms/Core/user_profile_controller.dart';
import 'package:hrms/Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import 'package:hrms/modules/Admin/Drawer/controllers/manage_users_controller.dart';
import 'package:hrms/modules/Admin/Drawer/views/drawer_screen.dart';
import 'package:hrms/modules/AdminDept/widget/bottom_appbar_widget1.dart';
import 'package:hrms/modules/AdminDept/widget/drawer_widget.dart';

class ManageUserMobile extends GetView<ManageUsersController> {
  const ManageUserMobile({super.key});
  static const String routeName = '/manage_user_mobile';

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
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: kBottomNavigationBarHeight + 40,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
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
                          if (controller.Username1.value.isEmpty) {
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
                                title: 'User Information',
                                color: Colors.blue.shade700,
                                fields: _buildUserInfoFields(controller),
                              ),
                              const SizedBox(height: 16),
                              _buildActionButtons(),
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
                controller.suggestionList1.clear();
                controller.suggestionList2.clear();
                controller.suggestionList3.clear();
                controller.suggestionList4.clear();
                controller.usernameSearchController.clear();
                Get.offAllNamed('/dashboard');
              },
            ),
            const Text("Back", style: TextStyle(color: Colors.white)),
          ],
        ),
        Text(
          "Manage User",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue.shade900,
            decorationThickness: 2,
            fontFamily: '7TH.ttf',
          ),
        ),
      ],
    );
  }

  Widget _buildInformationCard({
    required String title,
    required Color color,
    required List<Widget> fields,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...fields,
          ],
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade900),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  List<Widget> _buildUserInfoFields(ManageUsersController c) => [
    _field(
      label: 'User ID',
      icon: Icons.perm_identity_outlined,
      controller: c.UserIDController,
    ),
    _field(
      label: 'Staff Name',
      icon: Icons.person,
      controller: c.NameController,
    ),
    _field(
      label: 'Staff Manager',
      icon: Icons.group,
      controller: c.Managebyname,
    ),
    _field(
      label: 'Head Department Name',
      icon: Icons.person_2,
      controller: c.headname,
    ),
    _field(
      label: 'Head Department Position',
      icon: Icons.star,
      controller: c.headposition,
    ),
  ];

  Widget _buildSearchField(ManageUsersController controller) {
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
                controller.suggestionList1.clear();
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
                    controller.suggestionList1.clear();
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) {
              controller.Username1.value = v;
              if (v.trim().isNotEmpty) {
                controller.fetchSuggestions(1, v.trim());
              } else {
                controller.usernameSearchController.clear();
                controller.suggestionList1.clear();
              }
            },
          ),
          if (controller.suggestionList1.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 6),
              constraints: const BoxConstraints(maxHeight: 150),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.builder(
                itemCount: controller.suggestionList1.length,
                itemBuilder: (_, index) {
                  final s = controller.suggestionList1[index];
                  return ListTile(
                    title: Text(s),
                    onTap: () {
                      controller.usernameSearchController.text = s;
                      controller.Username1.value = s;
                      controller.fetchbyusersemployee(s);
                      controller.usernameSearchController.clear();
                      controller.suggestionList1.clear();
                    },
                  );
                },
              ),
            ),
        ],
      );
    });
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            await controller.createManageUser();
            showAwesomeSnackBarGetx(
              "Manage User",
              "User created successfully",
              ContentType.success,
            );
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blue.shade900,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
          ),
          child: const Text(
            "Create Manage User",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            controller.clearDataFields();
            controller.suggestionList1.clear();
            controller.suggestionList2.clear();
            controller.suggestionList3.clear();
            controller.suggestionList4.clear();
            controller.usernameSearchController.clear();
            Get.offAllNamed('/dashboard');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.grey.shade200,
            padding: const EdgeInsets.symmetric(horizontal: 78, vertical: 18),
          ),
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
