import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';
import '../model/notification_model.dart';

class MobileNotificationScreen extends StatefulWidget {
  const MobileNotificationScreen({super.key});
  static const routeName = '/mobile_notification';

  @override
  State<MobileNotificationScreen> createState() =>
      _MobileNotificationScreenState();
}

class _MobileNotificationScreenState extends State<MobileNotificationScreen> {
  final NotificationController controller = Get.find();
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    if (!isMobile && !isTablet) {
      Future.microtask(() => Get.offAllNamed('/overview'));
      return const SizedBox();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
          child: AppBar(
            toolbarHeight: 110,
            elevation: 15,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Notifications",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: '7TH.ttf',
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade900, Colors.blue.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.offAllNamed('/overview'),
            ),
            actions: [
              IconButton(
                tooltip: "Mark All as Read",
                icon: const Icon(Icons.done_all, color: Colors.white),
                onPressed: () => controller.markAllAsRead(),
              ),
              IconButton(
                tooltip: "Delete All",
                icon: const Icon(Icons.delete_forever, color: Colors.white),
                onPressed: () => controller.deleteAllNotifications(),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        final List<NotificationModel> list =
            showAll ? controller.allNotifications : controller.notifications;

        if (list.isEmpty) {
          return const Center(child: Text("No notifications"));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!showAll &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 50) {
              setState(() => showAll = true);
            }
            return false;
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length + (showAll ? 0 : 1),
            itemBuilder: (context, index) {
              if (!showAll && index == list.length) {
                return Center(
                  child: TextButton(
                    onPressed: () => setState(() => showAll = true),
                    child: const Text(
                      "Show All Notifications",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ),
                );
              }
              final e = list[index];
              return Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color:
                      (e.isRead ?? false)
                          ? Colors.grey.shade400
                          : Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(e.body, style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Text(
                          e.CreatedAt ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const Spacer(),
                        if (!(e.isRead ?? false))
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.blue,
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        TextButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.green.shade900,
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () => controller.markAsRead(e.id!),
                          icon: const Icon(
                            Icons.done,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Mark Read",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.blue.shade900,
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () => controller.markAsUnread(e.id!),
                          icon: const Icon(
                            Icons.undo,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Mark Unread",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.red.shade900,
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () => controller.deleteNotification(e.id!),
                          icon: const Icon(
                            Icons.delete,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
