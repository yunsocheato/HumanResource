class AttendanceChartModel {
  final String category;
  final int count;

  AttendanceChartModel({required this.category, required this.count});

  factory AttendanceChartModel.fromJson(Map<String, dynamic> json) {
    return AttendanceChartModel(
      category: json['check_type'] ?? 'Unknown',
      count: (json['count'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'check_type': category, 'count': count};
  }
}
