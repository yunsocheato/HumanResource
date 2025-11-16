import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class Skeletonlines extends StatelessWidget {
  const Skeletonlines({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int columnCount;
    if (screenWidth < 600) {
      columnCount = 2;
    } else if (screenWidth < 1000) {
      columnCount = 3;
    } else {
      columnCount = 4;
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
                        width: itemWidth.clamp(40, 400),
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
