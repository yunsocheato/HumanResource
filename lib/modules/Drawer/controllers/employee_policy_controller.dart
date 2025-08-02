import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Drawer/API/employee_policy_sql.dart';
import 'package:hrms/modules/Drawer/Model/employee_policy_model.dart';


class EmployeePolicyController extends GetxController{
  final employeepolicysql _sql = employeepolicysql();
  final RxInt fingerprint_id = 0.obs;
  final RxBool isPasswordHidden = true.obs;

  final IconData icon = Icons.search;
  final Color color = Colors.green.shade900;

  var isLoading = false.obs;
  var suggestionList = <String>[].obs;
  var user = Rx<employeepolicymodel?>(null);

  var Username = ''.obs;
  var Name = ''.obs;
  var Email = ''.obs;
  var Department = ''.obs;
  var id_card = ''.obs;
  var poisition = ''.obs;
  var Password = ''.obs;
  var Phone = ''.obs;
  var Address = ''.obs;
  var Gender = ''.obs;
  var DOB = ''.obs;
  var Role = ''.obs;
  var DateOfJoining = ''.obs;

  var usercannotchange = false.obs;
  var usercanchange = false.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(Username, (value) {
      fetchSuggestions(value);
    }, time: Duration(milliseconds: 300));
  }

  Future<void>fetchSuggestions(String Query) async {
    suggestionList.value = await _sql.fetchUsernameSuggestionsEmployee(Query);
  }

  Future<void>fetchbyusersemployee(String name ) async {
    isLoading.value = true ;
    try{
      var data = await _sql.fetchUserByEmployee(name);
      if(data != null){
        mapDataFields(data);
      }else {
        Get.snackbar('Error', 'User Not Found');
        clearDataFields();

      }
    }catch(e){
      Get.snackbar("Error", "Failed to load user");
      clearDataFields();

    }finally{
      isLoading.value = false;
    }
  }
  Future<void>UpdateChanges() async {
    if(user.value == null ) return;
    isLoading.value = true;
    try {
      await _sql.UpdateUser(user.value!);
      Get.snackbar('Success', 'User updated successfully');
    }catch (e){
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  void clearDataFields() {
    Username.value = '';
    Name.value = '';
    Email.value = '';
    Department.value = '';
    poisition.value = '';
    id_card.value = '';
    Password.value = '';
    fingerprint_id.value = 0;
    Phone.value = '';
    Address.value = '';
    Gender.value = '';
    DOB.value = '';
    Role.value = '';
    DateOfJoining.value = '';
  }

  void mapDataFields(employeepolicymodel data) {
    Username.value = data.name;
    Name.value = data.name;
    Email.value = data.email;
    Department.value = data.department;
    poisition.value = data.position;
    id_card.value = data.idCard;
    Password.value = data.password;
    fingerprint_id.value = data.fingerprint;
    Phone.value = data.phone;
    Address.value = data.address;
    Gender.value = data.gender;
    DOB.value = data.dob;
    Role.value = data.role;
    DateOfJoining.value = data.createdAt;
  }
}