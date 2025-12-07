import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Utils/HoverMouse/Widget/mouse_hover_widget.dart';
import 'package:hrms/Utils/Loadingui/Loading_skeleton.dart';
import '../../../../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../controllers/card_controller.dart';
import '../widgets/card_list_view.dart';

class Cardinfo extends GetView<CardController> {
  const Cardinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildRowlist();
  }

  Widget _buildRowlist() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isLaptop = width >= 1024 && width < 1440;
        final isDesktop = width >= 1440 && width < 2560;
        final isLargeDesktop = width >= 2560 && width < 3840;

        int crossAxisCount;
        double aspectRatio;
        double cardHeight;
        double fontSizeTitle;
        double fontSizeNumber;
        double fontSizeSubtitle;
        double iconSize;

        if (isMobile) {
          crossAxisCount = 2;
          aspectRatio = 1.5;
          cardHeight = 110;
          fontSizeTitle = 12;
          fontSizeNumber = 13;
          fontSizeSubtitle = 9;
          iconSize = 14;
        } else if (isTablet) {
          crossAxisCount = 4;
          aspectRatio = 1.6;
          cardHeight = 250;
          fontSizeTitle = 13;
          fontSizeNumber = 14;
          fontSizeSubtitle = 10;
          iconSize = 15;
        } else if (isLaptop) {
          crossAxisCount = 4;
          aspectRatio = 2.1;
          cardHeight = 210;
          fontSizeTitle = 13;
          fontSizeNumber = 18;
          fontSizeSubtitle = 12;
          iconSize = 21;
        } else if (isDesktop) {
          crossAxisCount = 4;
          aspectRatio = 2.6;
          cardHeight = 220;
          fontSizeTitle = 18;
          fontSizeNumber = 24;
          fontSizeSubtitle = 15;
          iconSize = 24;
        } else if (isLargeDesktop) {
          crossAxisCount = 4;
          aspectRatio = 3.0;
          cardHeight = 250;
          fontSizeTitle = 20;
          fontSizeNumber = 28;
          fontSizeSubtitle = 16;
          iconSize = 26;
        } else {
          crossAxisCount = 4;
          aspectRatio = 3.2;
          cardHeight = 280;
          fontSizeTitle = 22;
          fontSizeNumber = 30;
          fontSizeSubtitle = 18;
          iconSize = 28;
        }
        return Obx(() {
          if (controller.isLoading.value ||
              controller.isLoading1.value ||
              controller.isLoading3.value) {
            return const Center(child: Skeletonlines());
          }

          final cardData = getCardDataListview(controller);

          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            childAspectRatio: aspectRatio,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            children: List.generate(cardData.length, (index) {
              final item = cardData[index];
              return _buildCardInfo(
                index: index,
                title: item['title'],
                subtitle: item['subtitle'](controller),
                number: item['number'](controller),
                icon: item['icon'](controller),
                bgColor: Colors.white,
                iconBgColor: item['iconBgColor'],
                subtitleColor: Colors.white,
                iconColor: item['iconColor'](controller),
                cardHeight: cardHeight,
                fontSizeTitle: fontSizeTitle,
                fontSizeNumber: fontSizeNumber,
                fontSizeSubtitle: fontSizeSubtitle,
                iconSize: iconSize,
                imagePath: item['imagePath'],
              );
            }),
          );
        });
      },
    );
  }

  Widget _buildCardInfo({
    required int index,
    required String title,
    required String subtitle,
    required String number,
    required IconData icon,
    required Color bgColor,
    required Color iconBgColor,
    required Color subtitleColor,
    required Color iconColor,
    required double cardHeight,
    required double fontSizeTitle,
    required double fontSizeNumber,
    required double fontSizeSubtitle,
    required double iconSize,
    String? imagePath,
  }) {
    final HoverMouseController controller = Get.find<HoverMouseController>();

    final bool hasImage = imagePath != null && imagePath.isNotEmpty;

    return MouseHover(
      keyId: 18,
      controller: controller,
      child: Card(
        color: iconColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 15,
        shadowColor: Colors.black.withOpacity(0.4),
        child: Stack(
          children: [
            if (hasImage)
              Align(
                alignment: Alignment.centerRight,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Image.asset(
                    imagePath,
                    width: 150,
                    height: double.infinity,
                    color: Colors.white.withOpacity(0.3),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fontSizeTitle,
                            color: Colors.black.withOpacity(0.55),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      if (!hasImage)
                        Container(
                          height: iconSize * 1.4,
                          width: iconSize * 1.4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            size: iconSize,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),

                  const Spacer(),

                  Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSizeNumber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: fontSizeSubtitle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
