import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/leave_card_balance_model.dart';
import 'package:hrms/modules/AdminDept/Provider/leave_card_balance_provider.dart';
import 'package:hrms/modules/AdminDept/controller/leave_record_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Admin/Drawer/widgets/Method_drawer_policy_button.dart';

class OverViewController extends GetxController
    with SingleGetTickerProviderMixin {
  var isClockedIn = true.obs;
  var isLeaveRequestPending = false.obs;
  var isPayslipAvailable = true.obs;
  var leavecardbalance = <LeaveCardModel>[].obs;
  var leavecardrecord = <Map<String, dynamic>>[].obs;
  var currentUser = Rxn<User>();
  final currentPage = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final tabCount = 5;
  var isSelectedindex = 0.obs;

  final Color Selectedcolors = Colors.blue.shade900;
  final Color Unselectedcolors = Colors.grey;
  final controller = Get.put(LeaveRecordController());
  Timer? _timer;

  final List<String> managelist = [
    "Attendance",
    "Leave Record",
    "TEAM REQUEST",
    "User Management",
    "Leave Analyze",
    "Attendance Analyze",
  ];

  final List<String> managelist1 = [
    "Clock-in/Late",
    "Leave Request",
    "Team Request",
  ];

  final PageController pageController = PageController();
  final PageController pageController1 = PageController(initialPage: 0);
  final PageController pageController2 = PageController();

  final LeaveCardBalanceProvider _provider = Get.put(
    LeaveCardBalanceProvider(),
  );

  final images = RxList<String>([
    'https://media.licdn.com/dms/image/v2/D5622AQHGk5c59rD0tg/feedshare-shrink_800/B56ZmFDEMpJ0Ag-/0/1758873798150?e=2147483647&v=beta&t=ZprnqZ9QMlbRiMHeE1ZB1xam4n9h21ZSuZMLkzkmubI',

    'https://thumbs.dreamstime.com/b/logo-icon-vector-logos-icons-set-social-media-flat-banner-vectors-svg-eps-jpg-jpeg-paper-texture-glossy-emblem-wallpaper-210442411.jpg',

    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Oracle_Logo.svg/2560px-Oracle_Logo.svg.png',
  ]);

  final TextLeaves = RxList<List<dynamic>>([
    ['Annual Leave', 'assets/icon/calendar.png'],
    ['Sick Leave', 'assets/icon/hospital.png'],
    ['Maternity Leave', 'assets/icon/happy.png'],
    ['Unpaid Leave', 'assets/icon/wallet.png'],
  ]);

  final hoveredIndex = (-1).obs;
  final hoveredIndex1 = (-1).obs;
  final selectedIndex = (-1).obs;

  final overviewdashboard = RxList<DashboardItem>([
    DashboardItem(
      title: 'Request Leave',
      imagePath: 'assets/icon/calendars.png',
      color: Colors.white,
      onTap: () => Get.offAllNamed('/requestleave'),
    ),
    DashboardItem(
      title: 'Profile',
      imagePath: 'assets/icon/user.png',
      color: Colors.white,
      onTap: () => Get.offAllNamed('/userprofile'),
    ),
    DashboardItem(
      title: 'Attendance',
      imagePath: 'assets/icon/calendar.png',
      color: Colors.white,
      onTap: () => Get.offAllNamed('/attendance_user'),
    ),
    DashboardItem(
      title: 'Report',
      imagePath: 'assets/icon/folder.png',
      color: Colors.white,
      onTap: () => Get.offAllNamed('/report'),
    ),
  ]);

  var attendanceData = [].obs;
  var isLoading = true.obs;

  Duration duration = const Duration(milliseconds: 500);
  Curve curve = Curves.easeInOut;

  @override
  void onInit() {
    super.onInit();
    controller.loadCurrentUser();

    pageController.addListener(() {
      final page = pageController.page;
      if (page != null) {
        currentPage.value = page.round();
      }
    });
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
        controller.loadCurrentUser();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        leavecardbalance.clear();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      getLeaveRecordbalance();
      controller.loadCurrentUser();
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

  void refreshdata() async {
    await MethodButton1();
    update();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    pageController1.dispose();

    super.onClose();
  }

  BoxDecoration boxDecoration(int index) {
    return BoxDecoration(
      color: isSelectedindex.value == index ? Selectedcolors : Colors.white,
      borderRadius: BorderRadius.circular(5),
    );
  }

  Color iconColor(int index) {
    return isSelectedindex.value == index ? Colors.white : Unselectedcolors;
  }

  void SelectedIndex(int index) {
    isSelectedindex.value = index;
  }
}

class DashboardItem {
  final String title;
  final String imagePath;
  final Color color;
  final VoidCallback? onTap;

  DashboardItem({
    required this.title,
    required this.imagePath,
    required this.color,
    this.onTap,
  });
}

class TextLeave {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  TextLeave({required this.title, required this.imagePath, this.onTap});
}
