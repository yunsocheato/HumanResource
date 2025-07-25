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


  RxString errorMessage1 = ''.obs;
  RxString errorMessage2 = ''.obs;

  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;
  RxBool isLoading3 = true.obs;


  @override
  void onInit() {
    super.onInit();
    StreamUsers();
    CombinesStream1();
    CombinesStream2();
  }
  void StreamUsers() async {
    streamSignupUserAsModel().listen((event) {
      users.value = event;
      isLoading.value = false;
    }, onError: (_) {
      isLoading.value = false;
    }
    );
  }

  void CombinesStream1() async {
    combinedStream1.listen((data) {
      items1.value = data;
      isLoading2.value = false;
    }, onError: (error) {
      errorMessage1.value = error.toString();
      isLoading2.value = false;
    });
  }

  void CombinesStream2() async {
    combinedStream2.listen((data) {
      items2.value = data;
      isLoading3.value = false;
    }, onError: (error) {
      errorMessage2.value = error.toString();
      isLoading3.value = false;
    });
  }
}