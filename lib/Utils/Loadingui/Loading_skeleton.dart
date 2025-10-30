import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class Skeletonlines extends StatelessWidget {
  const Skeletonlines({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust number of columns dynamically
    int columnCount;
    if (screenWidth < 600) {
      columnCount = 3; // mobile
    } else if (screenWidth < 1000) {
      columnCount = 5; // tablet
    } else {
      columnCount = 8; // desktop/web
    }

    return SkeletonItem(
      child: Column(
        children: List.generate(25, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(columnCount, (i) {
                  final double baseWidth = screenWidth / (columnCount + 1);
                  final double itemWidth =
                      (i == 0) ? baseWidth * 1.8 : baseWidth * 0.7;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 16,
                        width: itemWidth.clamp(
                          40,
                          400,
                        ), // keep width in reasonable range
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        }),
      ),
    );
  }
}
