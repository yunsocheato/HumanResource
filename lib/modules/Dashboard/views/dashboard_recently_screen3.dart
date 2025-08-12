import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_recently_screen_controller.dart';
import '../controllers/dashboard_screen_controller.dart';

class Recentscreen3 extends GetView<RecentlyControllerScreen> {
  const Recentscreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;
        if (isMobile) {
          return _buildOBxResponsiveColumn(context) ;
        }
        else if (isTablet) {
          return _buildOBxResponsiveRow(context);
        }
        else if (isDesktop) {
          return _buildOBxResponsiveRow(context);
        }
        else {
          return _buildOBxResponsiveRow(context);
        }
      }
    );
  }
Widget _buildOBxResponsiveRow(BuildContext context) {
  final controller = Get.find<RecentlyControllerScreen>();
  return SizedBox(
    height: 300,
    width: 350,
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
                colors: [Colors.blue.shade700, Colors.blue.shade100],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Recent Records',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Stream content
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
                    item.icon ?? Icons.group_add,
                    item.color1 ?? Colors.blue,
                    item.color2 ?? Colors.blueAccent,
                    item.iconBgColor ?? Colors.grey,
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

Widget _buildOBxResponsiveColumn(BuildContext context) {
  final controller = Get.find<RecentlyControllerScreen>();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 300,
      width: double.infinity,
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
                  colors: [Colors.blue.shade700, Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Recent Records',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Stream content
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.items2.length,
                  itemBuilder: (context, index) {
                    final item = controller.items2[index];
                    return _buildcardinfo(
                      item.title,
                      item.description,
                      item.icon ?? Icons.group_add,
                      item.color1 ?? Colors.blue,
                      item.color2 ?? Colors.blueAccent,
                      item.iconBgColor ?? Colors.grey,
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





  Widget _buildcardinfo(
    String title,
    String Subtitles,
    IconData icon,
    Color color,
    Color colors,
    Color color1,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: colors.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 15, color: color),
              ),
              SizedBox(width: 11),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 50),
            child: Text(
              Subtitles,
              style: TextStyle(color: color1, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
