import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Bottomappbar/widget/bottomappbar_widget.dart';
import '../../Attendance/views/attendance_chart.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../controllers/dashboard_screen_controller.dart';
import 'dashboard_recent_employee.dart';
import 'dashboard_recently_screen1.dart';
import 'dashboard_recently_screen2.dart';
import 'dashboard_recently_screen3.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});
  static const String routeName = '/DashboardScreen';

  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 600;
    final contents = Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              if(isMobile)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildHeader(),
              ),
              SizedBox(height: 10),
              if(!isMobile)
                _buildHeader(),
              SizedBox(height: 15),
              Cardinfo(),
              SizedBox(height: 15),
              _buildcardinfo(),
            ],
          ),
        ),
      )
    );
    return isMobile
        ? BottomAppBarWidget(body: contents)
        : contents;
  }

  Widget _buildcardinfo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final isDesktop = constraints.maxWidth >= 1024;

        if (isMobile) {
          return _buildcardinfoRow();
        } else if (isTablet || isDesktop) {
          return _buildcardinfoColoum();
        }
        return _buildcardinfoColoum();
      },
    );
  }

  Widget _buildcardinfoColoum() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AttendacneChart(),
                ),
                const SizedBox(height: 15,width: 15),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Recentscreen2(),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Recentscreen3(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Recentemployee(),
          ),
        ],
      ),
    );
  }

  Widget _buildcardinfoRow() {
    final recentWidgets = const [
      Padding(
        padding: EdgeInsets.all(12.0),
        child: AttendacneChart(),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Recentscreen2(),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Recentscreen3(),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...recentWidgets.map(
              (widget) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: widget,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Recentemployee(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final Controller = Get.find<DashboardController>();
    final ctx = Get.context ?? Get.overlayContext;
    final isMobile = MediaQuery.of(ctx!).size.width < 600;
    return Obx(() => AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: Controller.showlogincard1.value ? 1.0 : 0.0,
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.only(
            top: Controller.showlogincard1.value ? 0 : 100,
          ),
          child: SizedBox(
            height: 70,
            child: Card(
              color: Colors.white,
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isMobile ? Row(
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.home_outlined, color: Colors.blue, size: 16)
                            ),
                            Stack(
                              children: <Widget>[
                                Text(
                                  'DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 16,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.blue[700]!,
                                  ),
                                ),
                                Text(
                                  'DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ) :
                        Row(
                          children: [
                            Stack(
                              children: <Widget>[
                                Text(
                                  'DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 24,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.blue[700]!,
                                  ),
                                ),
                                Text(
                                  'DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.home_outlined, color: Colors.blue, size: 24)),
                          ],
                        )

                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 20),
                        isMobile ? IconButton(onPressed: () => Controller.refreshdata()
                            , icon: Icon(Icons.refresh, color: Colors.blue, size: 16,)
                        ):
                        IconButton(onPressed: () => Controller.refreshdata()
                            , icon: Icon(Icons.refresh, color: Colors.blue, size: 24,)
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
