import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../controllers/dashboard_recently_screen_controller.dart';

class Recentscreen3 extends GetView<RecentlyControllerScreen> {
  const Recentscreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isLaptop = width >= 1440 && width < 2560;
        final isDesktop = width >= 1024 && width < 2560;
        final isLargeDesktop = width >= 2560;

        double cardHeight;
        double titleFontSize;
        double cardWidth;

        if (isMobile) {
          cardHeight = 300;
          titleFontSize = 12;
          cardWidth = double.infinity;
        } else if (isTablet) {
          cardHeight = 260;
          titleFontSize = 13;
          cardWidth = width * 0.2;
        } else if (isLaptop) {
          cardHeight = 265;
          titleFontSize = 14;
          cardWidth = width * 0.3;
        } else if (isDesktop) {
          cardHeight = 270;
          titleFontSize = 16;
          cardWidth = width * 0.35;
        } else if (isLargeDesktop) {
          cardHeight = 280;
          titleFontSize = 17;
          cardWidth = width * 0.4;
        } else {
          cardHeight = 320;
          titleFontSize = 22;
          cardWidth = width * 0.40;
        }
        if (isMobile || isTablet || isLaptop || isDesktop || isLargeDesktop) {
          return _buildTabletDesktop(
            context,
            cardHeight,
            titleFontSize,
            cardWidth,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildTabletDesktop(
    BuildContext context,
    double cardHeight,
    double titleFontSize,
    double cardWidth,
  ) {
    final controller = Get.find<RecentlyControllerScreen>();
    final HoverMouseController controller1 = Get.put(HoverMouseController());

    return MouseHover(
      keyId: 6,
      controller: controller1,
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: Card(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blueAccent.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Staff Records",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading3.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.errorMessage2.isNotEmpty) {
                    return Center(
                      child: Text('Error: ${controller.errorMessage2}'),
                    );
                  }
                  if (controller.items2.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.items2.length,
                    itemBuilder: (context, index) {
                      final item = controller.items2[index];
                      return _buildcardinfo(
                        item.title,
                        item.description,
                        item.icon,
                        item.color1,
                        item.color2,
                        item.iconBgColor,
                        titleFontSize,
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
  // Widget _buildMobile(BuildContext context, double cardHeight, double titleFontSize, double cardWidth) {
  //   final HoverMouse = Get.find<RecentlyControllerScreen>();
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [Colors.blue.shade700, Colors.blue.shade200],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(5),
  //         ),
  //         child: Text(
  //           "Staff Records",
  //           style: TextStyle(
  //             fontSize: titleFontSize,
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 10),
  //       SizedBox(
  //         height: cardHeight,
  //         child: Obx(() {
  //           if (HoverMouse.isLoading3.value) {
  //             return const Center(child: CircularProgressIndicator());
  //           }
  //           if (HoverMouse.errorMessage2.isNotEmpty) {
  //             return Center(child: Text('Error: ${HoverMouse.errorMessage2}'));
  //           }
  //           if (HoverMouse.items2.isEmpty) {
  //             return const Center(child: Text('No data available'));
  //           }
  //
  //           return ListView.separated(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: HoverMouse.items2.length,
  //             padding: const EdgeInsets.symmetric(horizontal: 12),
  //             separatorBuilder: (_, __) => const SizedBox(width: 12),
  //             itemBuilder: (context, index) {
  //               final item = HoverMouse.items2[index];
  //               return SizedBox(
  //                 width: cardWidth,
  //                 child: Card(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                   elevation: 3,
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         child: _buildcardinfo(
  //                           item.title,
  //                           item.description,
  //                           item.icon,
  //                           item.color1 ,
  //                           item.color2 ,
  //                           item.iconBgColor ,
  //                           titleFontSize,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         }),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildcardinfo(
  //   String title,
  //   String Subtitles,
  //   IconData icon,
  //   Color color,
  //   Color colors,
  //   Color color1,
  // ) {
  //   return Padding(
  //     padding: const EdgeInsets.all(12.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               height: 40,
  //               width: 40,
  //               decoration: BoxDecoration(
  //                 color: colors.withOpacity(0.2),
  //                 shape: BoxShape.circle,
  //               ),
  //               child: Icon(icon, size: 15, color: color),
  //             ),
  //             SizedBox(width: 11),
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(left: 50),
  //           child: Text(
  //             Subtitles,
  //             style: TextStyle(color: color1, fontSize: 12),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildcardinfo(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    Color backgroundColor,
    Color subtitleColor,
    double titleFontSize,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleFontSize - 4,
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
