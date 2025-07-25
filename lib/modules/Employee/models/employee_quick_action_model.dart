import 'package:flutter/cupertino.dart';

class BoxItemData {
  final String title;
  final IconData icon;
  final Color iconBackgroundColor; // Color for the icon's circular background
  final Color iconColor;         // Color for the icon itself

  BoxItemData({
    required this.title,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
  });
}