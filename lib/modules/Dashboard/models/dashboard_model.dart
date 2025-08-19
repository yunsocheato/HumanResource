import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hrms/modules/Dashboard/controllers/dashboard_recently_screen_controller.dart';

class DashboardModel {
  final String name;
  final String email;
  final String position;
  final String department;
  final Color color1;
  final Color color2;
  final Color iconBgColor;
  final IconData icondata;
  final String id_card;
  final DateTime created_at;


  DashboardModel({
    required this.name,
    required this.email,
    required this.position,
    required this.department,
    required this.id_card,
    required this.color1,
    required this.color2,
    required this.icondata,
    required this.iconBgColor,
    required this.created_at

  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      position: json['position'] ?? '',
      department: json['department'] ?? '',
      id_card: json['id_card'] ?? '',
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at']).toLocal()
          : DateTime.now(),
      color1: Colors.blue,
      color2: Colors.lightBlue,
      icondata: Icons.person,
      iconBgColor: Colors.grey.shade300,

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'id_card': id_card,
      'position': position,
      'department': department,
      'to_date': created_at.toLocal().toIso8601String(),
    };
  }
  get icon => RecentlyControllerScreen.icon;
  get iconColor => RecentlyControllerScreen.iconColor;

}