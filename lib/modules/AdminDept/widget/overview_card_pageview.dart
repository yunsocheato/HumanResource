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

        double width;
        double height;

        if (maxWidth < 600) {
          width = maxWidth;
          height = 220;
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

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.blue.shade300, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: controller.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    controller.images[index],
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error, color: Colors.grey, size: 40),
                      );
                    },
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
        );
      },
    );
  }
}
