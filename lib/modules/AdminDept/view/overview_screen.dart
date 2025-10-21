import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/overview_controller.dart';
import '../widget/bottom_appbar_widget1.dart';
import '../widget/drawer_widget.dart';
import '../widget/overview_widget.dart';

class OverViewScreen extends GetView<OverViewController> {
  const OverViewScreen({super.key});
  static const String routeName = '/overview';

  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 900;
    final contents = DrawerAdmin(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 10,
              ),
              child: _buildResponsiveContent(),
            ),
          ],
        ),
      ),
    );

    return isMobile ? BottomAppBarWidget1(body: contents) : contents;
  }

  Widget _buildResponsiveContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return isMobile ? _buildMobileContent() : _buildDesktopTabletContent();
      },
    );
  }

  Widget _buildMobileContent() {
    return const Padding(padding: EdgeInsets.all(8.0), child: OverViewWidget());
  }

  Widget _buildDesktopTabletContent() {
    return OverViewWidget();
  }
}
