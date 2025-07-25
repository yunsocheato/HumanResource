import 'dart:ui';

class ShowData {
  late String category;
  late double value;
  late Color color;

  ShowData({required this.category, required this.value, required this.color});

  ShowData.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    value = json['value'];
    color = json['color'];
  }
}