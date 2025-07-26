import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/attendance_chart_pie_model.dart';

class ChartPieController extends GetxController {
  final SupabaseClient client = Supabase.instance.client;
  RxList<ShowData> Chartpie = <ShowData>[
    ShowData(category: 'Annaul Leave', value: 0.0, color: Colors.red),
    ShowData(category: 'Sick Leave', value: 0.0, color: Colors.blue),
    ShowData(category: 'Emergency Leave', value: 0.0, color: Colors.orange),
    ShowData(category: 'Urgent Leave', value: 0.0, color: Colors.purple),
    ShowData(category: 'Late', value: 0.0, color: Colors.green),
    ShowData(category: 'CheckIN', value: 0.0, color: Colors.yellow),
  ].obs;

  final Map<String, Color> colorsMap = {
    'Annaul Leave': Colors.red,
    'Sick Leave': Colors.blue,
    'Emergency Leave': Colors.orange,
    'Urgent Leave': Colors.purple,
    'Late': Colors.green,
    'CheckIN': Colors.yellow,
  };
  @override
  void onInit() {
    super.onInit();
    _binstream();
  }

  void _binstream() {
    client
        .from('leave_requests')
        .stream(primaryKey: ['id'])
        .order('request_type', ascending: true)
        .listen((data) {
          Map<String, double> counts = {};
          for (var user in data) {
            final requestType = user['request_type'];
            if (requestType != null) {
              counts[requestType] = (counts[requestType] ?? 0) + 1;
            }
          }
          Chartpie.value = counts.entries.map((entry) {
            return ShowData(
              category: entry.key,
              value: entry.value,
              color: colorsMap[entry.key] ?? Colors.grey,
            );
          }).toList();
        });
  }
}