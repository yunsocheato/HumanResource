import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Attendance/controllers/attendance_widget_controller.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../Loadingui/Loading_Screen.dart';
import '../../../Loadingui/loading_controller.dart';
import '../../Attendance/controllers/attendane_screen_controller.dart';
import '../../Attendance/utils/ExportExcel.dart';
import '../../Attendance/utils/ExportPDF.dart';
import '../../CardInfo/views/card_screen.dart';
import '../widgets/leave_request_view.dart';
import '../../Drawer/views/drawer_screen.dart';
import '../../Employee/Controller/employeefiltercontroller.dart';
import '../API/leave_stream_rpc_sql.dart';

class LeaveRequest extends StatefulWidget {
  static const String routeName = '/LeaveRequest';

  const LeaveRequest({super.key});

  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final isMobile = Get.width < 600;
  final AttendanceScreenController controllers = Get.put(AttendanceScreenController());
  final loading = Get.find<LoadingUiController>();

  bool _showLoginCard = false;
  bool _showLoginCard1 = false;

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showLoginCard = true;
        _showLoginCard1 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile) _buildHeader(),
                    if (!isMobile) Padding(padding: const EdgeInsets.all(8), child: _buildHeader()),
                    const Cardinfo(),
                    const SizedBox(height: 10),
                    const leaverequesttable(),
                  ],
                ),
              ),
            ),
            if (loading.isLoading.value) const LoadingScreen(),
          ],
        ),
      ),
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
                        Text(
                          'LEAVE DASHBOARD',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () => controllers.refreshdata(),
                      child: Text(
                        'Refresh',
                        style: TextStyle(color: Colors.black, fontSize: isMobile ? 16 : 20),
                      ),
                    ),
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
