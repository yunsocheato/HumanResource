import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Admin/Loginscreen/services/logout_services.dart';
import 'drawer_header_widget.dart';

class DrawerAdmin extends StatelessWidget {
  final Widget content;

  const DrawerAdmin({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Get.width < 600;
    final bool isTablet = Get.width >= 600 && Get.width < 900;
    final bool showSidebar = !(isMobile || isTablet);
    final controller = Get.find<AuthController>();

    return Scaffold(
      drawer:
          (isMobile || isTablet)
              ? Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: DrawerHeader(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueGrey.shade900,
                              Colors.blueAccent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          boxShadow: [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 16),
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Icon(
                                  EneftyIcons.user_bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Scarlett",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "USER",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blueGrey.shade900, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(
                              Icons.dashboard_outlined,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "OVERVIEW",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: Icon(
                              EneftyIcons.user_bold,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "PROFILES",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(
                              EneftyIcons.folder_2_bold,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "REPORT",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(
                              EneftyIcons.calendar_2_bold,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "ATTENDANCE",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                          SizedBox(height: 350),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blueGrey.shade900,
                                    Colors.blueAccent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                title: const Text(
                                  "L O G O U T",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  controller.logoutWithConfirmation();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : null,
      body: Row(
        children: [
          if (showSidebar)
            Container(
              width: 65,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.dashboard_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  const SizedBox(height: 120),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.security_sharp,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.folder,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      controller.logoutWithConfirmation();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [const DrawerHead(), content],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
