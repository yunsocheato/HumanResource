import 'package:flutter/material.dart';

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Start from top-left
    path.lineTo(0, size.height * 0.8);

    // Smooth curve to top-right
    path.quadraticBezierTo(
      size.width * 0.5, // Control point X
      size.height, // Control point Y (the dip)
      size.width, // End point X
      size.height * 0.8, // End point Y
    );

    // Line to top-right corner
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// final profile = profileController.userprofiles.value;
// if (profile == null)
// return const Center(child: CircularProgressIndicator());
//
// final role = profile.role.toLowerCase();
// final isMobile = Get.width < 900;
//
//
// if (!isMobile) {
// return (role == 'admin' || role == 'superadmin')
// ? Drawerscreen(content: bodyContent)
//     : DrawerAdmin(content: bodyContent);
// }
//
// return isMobile ? BottomAppBarWidget1(body: contents) : contents;
//
// });
