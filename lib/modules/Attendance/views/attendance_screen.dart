import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CardInfo/views/card_screen.dart';
import '../../Drawer/controllers/drawer_controller.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';
import '../../Searchbar/view/search_bar_screen.dart';
import '../controllers/attendane_screen_controller.dart';
import 'attendance_chart.dart';
import 'attendance_chart_pie.dart';
import 'attendance_filter_view.dart';
import 'attendance_record.dart';

class AttendanceScreen extends StatefulWidget {
  static const String routeName = '/AttendanceScreen';

  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with TickerProviderStateMixin {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final AppDrawerController controller = Get.find<AppDrawerController>();
  final AttendanceScreenController controllers =
  Get.put(AttendanceScreenController());


  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Get.width < 600;
    final loading = Get.find<LoadingUiController>();

    return Drawerscreen(
      content: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Scrollbar(
              controller: _verticalScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildHeader(),
                      ),
                    if (!isMobile) _buildHeader(),
                    Cardinfo(),
                    _buildcardinfo(),
                  ],
                ),
              ),
            ),
            if (loading.isLoading.value)
               LoadingScreen(),
          ],
        )),
      );
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
        }else{
          return _buildcardinfoColoum();

        }
      },
    );
  }

  Widget _buildcardinfoColoum() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Row(
              children: [
                const AttendacneChart(),
                const SizedBox(width: 30),
                const AttendacneChartPie(),
                const SizedBox(width: 30),
              ],
            ),
          ),
          SizedBox(height: 20,),
          _CardinfoColumn()
        ],
      ),
    );
  }

  Widget _CardinfoColumn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
          child: Scrollbar(
            controller: _horizontalScrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _horizontalScrollController,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 100,
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: AttendanceFilterView(),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AttendanceRecords(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
      )
    );
}

  Widget _buildcardinfoRow() {
    final recentWidgets = const [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: AttendacneChart(),
      ),
      Padding(
        padding: EdgeInsets.all(10.0),
        child: AttendacneChartPie(),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Attendance Records',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicWidth(
                      child: AttendanceFilterView(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
               SearchbarScreen(),
              const SizedBox(height: 10),
              AttendanceRecords(),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildHeader() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Obx(
          () => AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: controllers.showlogincard2.value ? 1.0 : 0.0,
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          padding: EdgeInsets.only(
            top: controllers.showlogincard2.value ? 0 : 100,
          ),
          child: SizedBox(
            height: 70,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              shadowColor: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        isMobile ? Text(
                          'ATTENDANCE DASHBOARD',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ) : Text(
                          'ATTENDANCE DASHBOARD',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )

                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        isMobile ? TextButton(
                          onPressed: () => controllers.refreshdata(),
                          child: const Text(
                            'Refresh',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ): TextButton(
                          onPressed: () => controllers.refreshdata(),
                          child: const Text(
                            'Refresh',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
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
