import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_recently_screen_controller.dart';
import '../controllers/dashboard_screen_controller.dart'; // Contains your combinedStream

class Recentscreen2 extends GetView<RecentlyControllerScreen> {
  const Recentscreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;
        if (isMobile) {
          return buildOBxResponsiveColumn(context, isMobile: isMobile);
        } else if (isTablet) {
          return buildOBxResponsiveRow(context);
        } else if (isDesktop) {
          return buildOBxResponsiveRow(context);
        } else {
          return buildOBxResponsiveRow(context);
        }
      }
    );
  }

  Widget buildOBxResponsiveRow(BuildContext context) {
    final controller = Get.find<RecentlyControllerScreen>();
    return SizedBox(
      height: 300,
      width: 400,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.orangeAccent.shade700,
                    Colors.orangeAccent.shade100,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Recent Activity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.isLoading2.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.errorMessage1.isNotEmpty) {
                  return Center(
                    child: Text('Error: ${controller.errorMessage1}'),
                  );
                }
                if (controller.items1.isEmpty) {
                  return const Center(child: Text('No data available'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.items1.length,
                  itemBuilder: (context, index) {
                    final item = controller.items1[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: _buildCardInfo(
                        item.title,
                        item.description,
                        item.photo as String ,
                        item.color1,
                        item.color2,
                        item.iconBgColor,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOBxResponsiveColumn(BuildContext context, {required bool isMobile}) {
    final controller = Get.find<RecentlyControllerScreen>();
    Widget header = Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade700,
                  Colors.blue.shade100,
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Center(
              child: const Text(
                'Activity',
                style: TextStyle(fontSize: 16,color: Colors.white ,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );

    Widget listView = SizedBox(
      height: 130,
      child: Obx(() {
        if (controller.isLoading2.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage1.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage1}'));
        }

        if (controller.items1.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.items1.length,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final item = controller.items1[index];

            return SizedBox(
              width: 250,
              child: Card(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: item.color1,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildCardInfo(
                        item.title,
                        item.description,
                        item.photo as String ,
                        item.color1,
                        item.color2,
                        item.iconBgColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          listView,
        ],
      );
    } else {
      return buildOBxResponsiveRow(context);
    }
  }

  Widget _buildCardInfo(
      String title,
      String subtitle,
      String photoUrl,
      Color color,
      Color backgroundColor,
      Color subtitleColor,
      ) {
    return Obx(() {
      final controller = Get.find<RecentlyControllerScreen>();
      // ImageProvider imageProvider = controller.isRight.value
      //     ? NetworkImage(photoUrl) : AssetImage('assets/images/profileuser.png');
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: (controller.isRight.value || photoUrl.isEmpty)
                        ? AssetImage('assets/images/profileuser.png')
                        : NetworkImage(photoUrl),
                  ),

                  SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0,left: 65),
                child: Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: subtitleColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

}
