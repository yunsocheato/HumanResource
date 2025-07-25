import 'package:flutter/material.dart';

class MutipleModel1 {
  final String title;
  final String description;
  final IconData icon;
  final Color color1;
  final Color color2;
  final Color iconBgColor;

  MutipleModel1({
    required this.title,
    required this.description,
    required this.icon,
    required this.color1,
    required this.color2,
    required this.iconBgColor,
  });

  factory MutipleModel1.fromJson(Map<String, dynamic> json) {
    return MutipleModel1(
      title: json['username'] ?? 'No Name',
      description: json['description'] ?? '',
      icon: Icons.info,
      color1: Colors.blue,
      color2: Colors.lightBlue,
      iconBgColor: Colors.grey.shade300,
    );
  }
}
