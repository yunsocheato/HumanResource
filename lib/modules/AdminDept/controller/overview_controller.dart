import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/leave_card_balance_model.dart';
import 'package:hrms/modules/AdminDept/Provider/leave_card_balance_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Admin/Drawer/widgets/Method_drawer_policy_button.dart';
import '../view/request_leave_screen.dart';

class OverViewController extends GetxController
    with SingleGetTickerProviderMixin {
  var isClockedIn = true.obs;
  var isLeaveRequestPending = false.obs;
  var isPayslipAvailable = true.obs;
  var leavecardbalance = <LeaveCardModel>[].obs;
  var leavecardrecord = <Map<String, dynamic>>[].obs;
  var currentUser = Rxn<User>();

  Timer? _timer;

  final PageController pageController = PageController();
  final LeaveCardBalanceProvider _provider = Get.put(
    LeaveCardBalanceProvider(),
  );

  final images = [
    'https://bongsrey.sgp1.digitaloceanspaces.com/library/10204/images/thumbnail/5ec74e5b86b19.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Cisco_logo_blue_2016.svg/640px-Cisco_logo_blue_2016.svg.png',
    'https://logos-world.net/wp-content/uploads/2020/09/Oracle-Logo.png',
  ];

  final TextLeave = RxList<List<dynamic>>([
    ['Annual Leave', Icons.calendar_today, Colors.white],
    ['Sick Leave', Icons.sick, Colors.white],
    ['Maternity Leave', Icons.pregnant_woman, Colors.white],
    ['Unpaid Leave', Icons.money, Colors.white],
  ]);
  final hoveredIndex = (-1).obs;
  final hoveredIndex1 = (-1).obs;
  final selectedIndex = (-1).obs;

  final overviewdashboard = RxList<DashboardItem>([
    DashboardItem(
      title: 'Request Leave',
      icon: Icons.calendar_today,
      color: Colors.white,
      onTap: () => Get.to(() => RequestLeaveScreen()),
    ),
    DashboardItem(
      title: 'Department',
      icon: Icons.apartment,
      color: Colors.white,
    ),
    DashboardItem(
      title: 'Leave Balance',
      icon: Icons.safety_check,
      color: Colors.white,
    ),
    DashboardItem(
      title: 'Schedule',
      icon: Icons.calendar_month,
      color: Colors.white,
    ),
  ]);

  var attendanceData = [].obs;
  var isLoading = true.obs;

  Duration duration = const Duration(milliseconds: 500);
  Curve curve = Curves.easeInOut;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(0);
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageController.hasClients) {
        final nextPage =
            ((pageController.page?.round() ?? 0) + 1) % images.length;

        pageController.animateToPage(
          nextPage,
          duration: duration,
          curve: curve,
        );
      }
    });
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        getLeaveRecordbalance();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        leavecardbalance.clear();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      getLeaveRecordbalance();
    }
  }

  Future<void> getLeaveRecordbalance() async {
    try {
      isLoading.value = true;
      final data = await _provider.getAllLeaveRecordBalance();
      leavecardbalance.value = data;
    } catch (e) {
      leavecardbalance.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void toggleClockStatus(bool value) {
    isClockedIn.value = value;
    Get.snackbar(
      "Status",
      value ? "Clocked In successfully!" : "Clocked Out successfully!",
    );
  }

  void toggleLeaveRequest(bool value) {
    isLeaveRequestPending.value = value;
    Get.snackbar(
      "Status",
      value ? "Leave request initiated." : "Leave request cancelled.",
    );
  }

  void fetchDashboardData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    attendanceData.value = [
      {'dept': 'HR', 'count': 0.5},
      {'dept': 'IT', 'count': 1.0},
    ];
    isLoading.value = false;
  }

  void refreshdata() async {
    await MethodButton1();
    update();
  }

  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  DashboardItem({
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });
}