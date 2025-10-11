import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Department/Api/announcement_sql.dart';
import 'package:hrms/modules/Department/models/announcement_model.dart';
import 'package:hrms/modules/Department/views/department_screen.dart';

import '../../Dashboard/views/dashboard_screen.dart';
import '../../Drawer/widgets/Method_drawer_policy_button.dart';
import '../Api/department_sql.dart';
import '../models/department_model.dart';

class DepartmentScreenController extends GetxController {
  var showCards = true.obs;
  var recentDataLoaded = false.obs;
  var isLoading = true.obs;
  var isSelectedindex = 0.obs;
  var  showlogincard1 = true.obs;
  final tabCount = 2;
  final progress = 0.0.obs;
  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();

  final Color Selectedcolors = Colors.blue.shade900;
  final Color Unselectedcolors = Colors.grey;

  final List<String> departments = ["Departments", "Announcements"];
  final DepartmentSQL departmentSQL = DepartmentSQL();

  final AnnouncementSQL announcementSQL = AnnouncementSQL();

  final PageController pageController = PageController(initialPage: 0);

  BoxDecoration boxDecoration(int index) {
    return BoxDecoration(
      color: isSelectedindex.value == index ? Selectedcolors : Colors.white,
      borderRadius: BorderRadius.circular(5),
    );
  }

  void toogleShowlogincard1 () {
    showlogincard1.value = !showlogincard1.value;
  }

  void refreshdata() async {
    await MethodButton4();
    isLoading.value = false;
  }

  @override
  void onInit() {
    loaddata();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    super.onClose();
  }

  void SelectedIndex(int index){
    isSelectedindex.value = index;
  }

  void loaddata() async {
    await Future.delayed(Duration(seconds: 2));
    fetchDepartmentUsers();
    isLoading.value = false;
  }

  Color iconColor(int index){
    return isSelectedindex.value == index ? Colors.white : Unselectedcolors;
  }

  Future<List<DepartmentModel>> fetchDepartmentUsers() async {
    return await departmentSQL.getUsersByDepartment();
  }

  Future<List<AnnouncementModel>> fetchAnnouncementUsers() async {
    return await announcementSQL.getUsersByAnnouncement();
  }

}
