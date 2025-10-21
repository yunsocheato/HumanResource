import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../API/dashboard_stream_data_mutiple2_sql.dart';
import '../models/dashboard_get_mutiple2_data_model.dart';
import '../models/dashboard_model.dart';
import '../models/dashboard_get_mutiple1_data_model.dart';
import '../API/dashboard_stream_data_mutiple1_sql.dart';
import '../API/dashboard_stream_recently1_sql.dart';

class RecentlyControllerScreen extends GetxController{
  RxList<MutipleModel1> items1 = <MutipleModel1>[].obs;
  RxList<MutipleModel2> items2 = <MutipleModel2>[].obs;
  RxList<DashboardModel> users = <DashboardModel>[].obs;

  static final icon = Icons.person;
  static final iconColor = Colors.blue;
  static final iconBgColor = Colors.white;

  final RxBool isRight = false.obs;

  RxString errorMessage1 = ''.obs;
  RxString errorMessage2 = ''.obs;

  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;
  RxBool isLoading3 = true.obs;


  @override
  void onInit() {
    super.onInit();
    loadUsers();
    loadCombine1();
    loadCombine2();
  }
  Future<void> loadUsers() async {
    try {
      final result = await FetchUserasModel();
      users.value = result;
    } catch (e) {
      errorMessage1.value = "User fetch error: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCombine1() async {
    try {
      final result = await fetchCombined1();
      items1.value = result;
    } catch (e) {
      errorMessage1.value = "Combine1 fetch error: $e";
    } finally {
      isLoading2.value = false;
    }
  }

  Future<void> loadCombine2() async {
    try {
      final result = await fetchEmployeeScanRecords();
      items2.value = result;
    } catch (e) {
      errorMessage2.value = "Combine2 fetch error: $e";
    } finally {
      isLoading3.value = false;
    }
  }

}