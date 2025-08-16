import 'package:get/get.dart';
import '../API/employee_checkin_sql.dart';
import '../Model/employee_checkin_model.dart';

class EmployeeCheckinController extends GetxController{
  final _employeecheckinModel = <EmployeeCheckinModel>[].obs;
  final _employeeCheckinSQL = empoloyeecheckINSQL();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindStream();
  }

  void _bindStream(){
    isLoading.value = true;
    _employeeCheckinSQL.employeecheckin().listen((event) {
      _employeecheckinModel.assignAll(event);
      isLoading.value = false;
    },
      onError: (error) {
        isLoading.value = false;
        Get.snackbar('Error', error.toString());

      }
    );
  }
}

class EmployeeCheckinCount extends GetxController{
  final _employeeCheckinCountModel = <EmployeeCheckinCountModel>[].obs;
  final _employeeCheckinSQL = empoloyeecheckINSQL();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _bindStream();
  }

  void _bindStream() {
    isLoading.value = true;
    _employeeCheckinSQL.employeecheckinCount().listen((event) {
      _employeeCheckinCountModel.assignAll(event);
      isLoading.value = false;
    }, onError: (error) {
      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    }
    );
  }
}