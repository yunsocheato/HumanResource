import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChartController extends GetxController {
  final SupabaseClient client = Supabase.instance.client;
  var selectedValue =  ''.obs;
  RxList<double> counts = [ 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ].obs;
  List <Color> colors = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.purple, Colors.orange];
  List<String>departments = ['Human Resource', 'Information Technology', 'Finance Department', 'Sales Department', 'Administrator Department' , 'ATM Department'];
  @override
  void onInit() {
    super.onInit();
    _bindStream();
  }
  void updateHover(int index, double value) {
    counts[index] = value;
  }
  void _bindStream() {
    client.from('singupuser_fit_attendance')
        .stream(primaryKey: ['id'])
        .order('department', ascending: true)
        .listen((data) {
      List<int> updatedCounts = [0, 0, 0, 0, 0, 0];

      for (var user in data) {
        final dept = user['department'];
        final index = departments.indexOf(dept);
        if (index != -1) {
          updatedCounts[index]++;
        }
      }

      counts.value = updatedCounts.cast<double>();
    });
  }
}

