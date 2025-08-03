import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AccessFeatureController extends GetxController{
  final Rx<UserRole> selectedRole1 = UserRole.user.obs;
  final Rx<UserRole> selectedRole2 = UserRole.admin.obs;
  final Rx<UserRole> selectedRole3 = UserRole.supervisor.obs;
  final Rx<UserRole> selectedRole4 = UserRole.superAdmin.obs;


  RxBool UserisAccessFeature = false.obs;
  RxBool SupervisorisAccessFeature = false.obs;
  RxBool AdminisAccessFeature = false.obs;
  RxBool SuperAdminisAccessFeature = false.obs;

  final List<String> UserAccessFeature = <String>[].obs;
  final List<String> AdminAccessFeature = [];
  final List<String> SuperAdminAccessFeature = [];

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