class LeaveChartModel {
  final DateTime fromDate;
  final DateTime toDate;

  LeaveChartModel({required this.fromDate, required this.toDate});

  factory LeaveChartModel.fromMap(Map<String, dynamic> map) {
    return LeaveChartModel(
      toDate:
          DateTime.tryParse(map['to_date']?.toString() ?? '') ?? DateTime.now(),
      fromDate:
          DateTime.tryParse(map['from_date']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}
