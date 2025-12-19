import 'package:flutter/material.dart';
import '../controllers/card_controller.dart';

List<Map<String, dynamic>> getCardDataListview(CardController controller) {
  return [
    {
      'title': 'Total Employees',
      'subtitle': (CardController c) => c.growth.value,
      'number': (CardController c) => c.total.value,
      'icon': (CardController c) => c.icon.value,
      'iconColor': (CardController c) => Colors.purple,
      'iconBgColor': Colors.purple.shade100,
      'imagePath': 'assets/icon/user.png',
    },
    {
      'title': 'Attendance Today',
      'subtitle': (CardController c) {
        final count = c.presentcount.value;
        return count == 0
            ? '0 employee attended today'
            : '$count employees attended today';
      },
      'number': (CardController c) => '${c.percentage.value.toInt()}%',
      'icon': (CardController c) => Icons.person_pin_circle,
      'iconColor': (CardController c) => Colors.blue,
      'iconBgColor': Colors.green.shade100,
      'imagePath': 'assets/icon/calendar.png',
    },
    {
      'title': 'Department',
      'subtitle':
          (CardController c) => '${c.largestDepartment.value} Team is Largest',
      'number': (CardController c) => '${c.totalDepartment.value} Department',
      'icon': (CardController c) => Icons.apartment,
      'iconColor': (CardController c) => Colors.green,
      'iconBgColor': Colors.red.shade100,
      'imagePath': 'assets/images/department.png',
    },
    {
      'title': 'Available open position',
      'subtitle': (CardController c) => '3 in Engineering',
      'number': (CardController c) => '5',
      'icon': (CardController c) => Icons.shopping_bag,
      'iconColor': (CardController c) => Colors.orange,
      'iconBgColor': Colors.orange.shade100,
      'imagePath': 'assets/images/available.png',
    },
  ];
}
