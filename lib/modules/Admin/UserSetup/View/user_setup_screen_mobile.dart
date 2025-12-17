import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Core/user_profile_controller.dart';
import 'package:hrms/Utils/Bottomappbar/widget/bottomappbar_widget.dart';
import 'package:hrms/modules/Admin/Drawer/views/drawer_screen.dart';
import 'package:hrms/modules/Admin/UserSetup/Controller/user_setup_controller.dart';
import 'package:hrms/modules/AdminDept/widget/bottom_appbar_widget1.dart';
import 'package:hrms/modules/AdminDept/widget/drawer_widget.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';

class UserSetupScreenMobile extends GetView<UserSetupController> {
  const UserSetupScreenMobile({super.key});
  static const String routeName = '/user_setup_mobile';

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
      final isMobile = Get.width < 900;
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

                        _buildInformationCard(
                          title: "Basic Information",
                          color: Colors.blue.shade700,
                          fields: _basicFields(),
                        ),
                        const SizedBox(height: 16),

                        _buildInformationCard(
                          title: "Contact Information",
                          color: Colors.green.shade700,
                          fields: _contactFields(),
                        ),
                        const SizedBox(height: 16),

                        _buildInformationCard(
                          title: "Work Information",
                          color: Colors.orange.shade700,
                          fields: _workFields(),
                        ),
                        const SizedBox(height: 15),
                        _buildButtons(),
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
              onPressed: () => Get.offAllNamed('/dashboard'),
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
          "Create User",
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

  Widget _buildInformationCard({
    required String title,
    required Color color,
    required List<Map<String, dynamic>> fields,
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

            const SizedBox(height: 16),

            ...fields.map(
              (item) => _buildField(
                label: item['label'],
                controller: item['controller'],
                icon: item['icon'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 18),
          ),
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
        ),

        const SizedBox(width: 10),

        ElevatedButton(
          onPressed: () async {
            await controller.createuser();

            showAwesomeSnackBarGetx(
              "Success",
              "User Created Successfully",
              ContentType.success,
            );

            Get.offAllNamed('/dashboard');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.blue.shade900,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
          ),
          child: const Text(
            "Create User",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade900),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _basicFields() {
    return [
      {
        'label': 'Full Name',
        'icon': Icons.person,
        'controller': controller.NameController,
      },
      {
        'label': 'Email',
        'icon': Icons.email,
        'controller': controller.EmailController,
      },
      {
        'label': 'Fingerprint ID',
        'icon': Icons.fingerprint,
        'controller': controller.fingerprint_idController,
      },
      {
        'label': 'Department',
        'icon': Icons.apartment,
        'controller': controller.DepartmentController,
      },
      {
        'label': 'Role',
        'icon': Icons.star,
        'controller': controller.RoleController,
      },
    ];
  }

  List<Map<String, dynamic>> _contactFields() {
    return [
      {
        'label': 'Phone',
        'icon': Icons.phone,
        'controller': controller.PhoneController,
      },
      {
        'label': 'Address',
        'icon': Icons.location_on,
        'controller': controller.AddressController,
      },
    ];
  }

  List<Map<String, dynamic>> _workFields() {
    return [
      {
        'label': 'Position',
        'icon': Icons.chair,
        'controller': controller.poisitionController,
      },
      {
        'label': 'Password',
        'icon': Icons.lock,
        'controller': controller.passwordController,
      },
    ];
  }
}
