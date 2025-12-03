import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/overview_controller.dart';

class PageOverviewScreen extends GetView<OverViewController> {
  const PageOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final bool isMobile = maxWidth < 600;

        double width;
        double height;

        if (isMobile) {
          width = maxWidth;
          height = 140;
        } else if (maxWidth >= 600 && maxWidth < 900) {
          width = MediaQuery.of(context).size.width * 0.6;
          height = 250;
        } else if (maxWidth >= 900 && maxWidth < 1440) {
          width = MediaQuery.of(context).size.width * 0.7;
          height = 420;
        } else {
          width = 900;
          height = 500;
        }

        return Column(
          children: [
            Container(
              width: width,
              height: height,
              decoration:
                  isMobile
                      ? null
                      : BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        isMobile
                            ? EdgeInsets.zero
                            : const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 10.0,
                            ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isMobile ? 10 : 20),
                      child: Image.network(
                        controller.images[index],
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.blue.shade900,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: controller.currentPage.value == index ? 14 : 8,
                    height: controller.currentPage.value == index ? 14 : 8,
                    decoration: BoxDecoration(
                      color:
                          controller.currentPage.value == index
                              ? Colors.blue.shade900
                              : Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
