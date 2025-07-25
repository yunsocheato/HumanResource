
import 'package:get/get.dart';
import '../../Drawer/widgets/Method_drawer_policy_button.dart';

class AttendanceScreenController extends GetxController {
  var  showlogincard2 = true.obs;
  var showCards = true.obs;
  var recentDataLoaded = false.obs;
  var isLoading = true.obs;

  void toogleShowlogincard1 () {
    showlogincard2.value = !showlogincard2.value;
  }

  void refreshdata() async {
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }
}