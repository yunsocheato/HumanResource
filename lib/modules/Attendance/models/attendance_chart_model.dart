import 'dart:ui';

class Chartmodel {
  late  String category;
  late  double value;
  late  Color color;

  Chartmodel({required this.category, required this.value, required this.color});

  factory Chartmodel.fromJson(Map<String, dynamic> json) {
    return Chartmodel(
      category: json['category'],
      value: json['value'],
      color: json['color'],
    );
  }
}

