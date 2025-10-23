import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class Skeletonlines extends StatelessWidget {
  const Skeletonlines({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Column(
        children: List.generate(25, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(8, (i) {
                return SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 16,
                    width: (i == 0) ? 250 : 80,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
