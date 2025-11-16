import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Admin/Notification/controllers/notification_controller.dart';

import '../../../../Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  final String? userId;
  final List<String> roles;

  const NotificationScreen({super.key, required this.roles, this.userId});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // PopupMenuButton wrapped in Stack for badge
      return Stack(
        clipBehavior: Clip.none,
        children: [
          _buildPopupMenuButton(),
          if (controller.notificationcounts.value > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${controller.notificationcounts.value}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildPopupMenuButton() {
    Widget iconUser = Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade900.withOpacity(0.7),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      padding: const EdgeInsets.all(8),
      child: const Icon(Icons.notifications, size: 32, color: Colors.white),
    );

    Widget iconAdmin = const Icon(
      Icons.notifications,
      size: 32,
      color: Colors.white,
    );

    if (roles.contains("admin") || roles.contains('superadmin')) {
      final controller2 = Get.find<HoverMouseController>();
      iconAdmin = MouseHover(
        keyId: 20,
        controller: controller2,
        child: iconAdmin,
      );
    }

    Widget icon = roles.contains("user") ? iconUser : iconAdmin;

    return PopupMenuButton<int>(
      offset: const Offset(0, 40),
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (_) {
        final uid = controller.currentUser.value?.id;
        final items =
            controller.notifications
                .where((n) {
                  if (uid != null && roles.contains('user')) {
                    return n.userID == uid;
                  }
                  return true;
                })
                .take(5)
                .toList();

        return [
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("No notifications"),
                    )
                  else
                    ...items.map(
                      (e) => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(e.body),
                          ],
                        ),
                      ),
                    ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      _showAllNotifications(controller);
                    },
                    child: const Text(
                      "Show All Notifications",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      child: icon,
    );
  }

  void _showAllNotifications(NotificationController controller) {
    final user = controller.currentUser.value;
    if (user == null) {
      controller.initializeNotifications(user!.id);
    } else {
      Get.snackbar('Error', 'User not loggin');
    }
    Get.dialog(
      Dialog(
        child: Container(
          width: 450,
          height: 600,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                "All Notifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.delete),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      iconColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    label: Text(
                      'Delete all Notification',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final items =
                      controller.allnotifications
                          .where(
                            (n) =>
                                roles.contains('user , admin, superadmin')
                                    ? n.userID == userId
                                    : true,
                          )
                          .toList();

                  if (items.isEmpty) {
                    return const Center(child: Text("No notifications yet"));
                  }

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      final item = items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                PopupMenuButton<int>(
                                  icon: const Icon(
                                    Icons.list,
                                    color: Colors.black,
                                  ),
                                  itemBuilder:
                                      (context) => [
                                        PopupMenuItem(
                                          value: 1,
                                          child: TextButton(
                                            onPressed: () {
                                              // Delete notification logic
                                            },
                                            child: const Text(
                                              "Delete this notification",
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: TextButton(
                                            onPressed: () {},
                                            child: const Text("Mark as read"),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 3,
                                          child: TextButton(
                                            onPressed: () {
                                              // Mark as unread logic
                                            },
                                            child: const Text("Mark as unread"),
                                          ),
                                        ),
                                      ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.CreatedAt != null
                                  ? item.CreatedAt.toString().substring(0, 16)
                                  : '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
