import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 &&
            constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;

        if (isMobile) {
          return _buildOBxResponsiveColoum();
        } else if (isTablet) {
          return _buildOBxResponsiveRow();
        } else if (isDesktop) {
          return _buildOBxResponsiveRow();
        } else {
          return _buildOBxResponsiveRow(); // fallback, empty widget
        }
      },
    );
  }


  Widget _buildOBxResponsiveRow() {
    final cardData = getCardDataListview(controller);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controller.isLoading.value ||
              controller.isLoading1.value ||
              controller.isLoading3.value) {
            return const Center(child: CircularProgressIndicator());
          }
      
          return GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 2.5,
            mainAxisSpacing: 1,
            crossAxisSpacing: 4,
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
                subtitleColor: Colors.grey.shade600,
                iconColor: item['iconColor'](controller),
              );
            }),
          );
        }),
      ),
    );
  }


  Widget _buildOBxResponsiveColoum() {
    final cardData = getCardDataListview(controller);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        if (controller.isLoading.value ||
            controller.isLoading1.value ||
            controller.isLoading3.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 3,
          crossAxisSpacing: 1,
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
              subtitleColor: Colors.grey.shade600,
              iconColor: item['iconColor'](controller),
            );
          }),
        );
      }),
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
  }) {
    return Card(
      color: iconColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      shadowColor: Colors.grey.withOpacity(0.2),
      child: SizedBox(
        height: 150,
        width: 356,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
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
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: iconBgColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 20, color: bgColor),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  number,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}