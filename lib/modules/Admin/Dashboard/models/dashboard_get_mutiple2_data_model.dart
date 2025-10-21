import 'package:flutter/material.dart';

class MutipleModel2 {
  final String title;
  final String description;
  final IconData icon;
  final String  photo;
  final Color color1;
  final Color color2;
  final Color iconBgColor;

  MutipleModel2({
    required this.title,
    required this.description,
    required this.icon,
    required this.photo,
    required this.color1,
    required this.color2,
    required this.iconBgColor,
  });

  factory MutipleModel2.fromJson(Map<String, dynamic> json) {
    return MutipleModel2(
      title: json['name'] ?? 'No Name',
      photo: json['photo_url'] ?? '',
      description: json['description'] ?? '',
      icon: Icons.info,
      color1: Colors.blue,
      color2: Colors.lightBlue,
      iconBgColor: Colors.grey.shade300,
    );
  }
}
