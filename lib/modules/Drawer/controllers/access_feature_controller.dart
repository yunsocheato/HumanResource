import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AccessFeatureController extends GetxController{

  int? selectedIndex;

  final Rx<UserRole?> selectedRole = Rx<UserRole?>(null);



  final Map<UserRole ,List<String>> UserRoleMap = {
    UserRole.user: ['user'],
    UserRole.supervisor: ['supervisor'],
    UserRole.admin: ['admin'],
    UserRole.superAdmin: ['superAdmin'],

  };
  final Map<UserRole, List<String>> permissionMap = {
    UserRole.superAdmin: ['Create', 'Read', 'Update', 'Delete','Approve','Reject'],
    UserRole.admin: ['Create', 'Read', 'Update', 'Delete','Approve','Reject'],
    UserRole.user: ['Update', 'Read' , 'Request'],
    UserRole.supervisor: ['Read', 'Update', 'Approve','Reject'],
  };
  final Map<UserRole, List<String>> featureaccessMap = {
    UserRole.admin: [
      'Dashboard',
      'Manage Users',
      'Leave Requests',
      'Reports',
      'Settings',
    ],
    UserRole.user: [
      'Dashboard',
      'Submit Leave',
      'View Attendance',
    ],
    UserRole.supervisor: [
      'Dashboard',
      'Approve Leave',
      'Team Reports',
    ],
    UserRole.superAdmin: [
      'Dashboard',
      'Employee Records',
      'Recruitment',
      'Payroll',

    ],
  };


  final IconData icon  = Icons.search ;
  final Color color = Colors.yellow;

  var OwnData = [].obs;
  var AllData = [].obs;
  var UserAllData = [].obs;
  var isLoading = false.obs;

  var Username = "".obs;
  RxBool usercannotchange = false.obs;
  RxBool usercanchange = false.obs;


  @override
  void onInit() {
    super.onInit();
  }


}
enum UserRole {
  superAdmin,
  admin,
  supervisor,
  user,
}
