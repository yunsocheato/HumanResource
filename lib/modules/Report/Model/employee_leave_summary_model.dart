class EmployeeLeaveSummaryModel {
  final String staff_id ;
  final String name;
  final String department;
  final String position;
  final String request_type;
  final double leave_count;

  EmployeeLeaveSummaryModel({
    required this.staff_id,
    required this.name,
    required this.department,
    required this.position,
    required this.request_type,
    required this.leave_count,
  });

  factory EmployeeLeaveSummaryModel.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveSummaryModel(
      staff_id: json['staff_id'] ,
      name: json['name'],
      department: json['department'] ,
      position: json['position'] ,
      request_type: json['request_type'] ,
      leave_count: (json['leave_count'] as num).toDouble(),
    );
  }

  Map <String, dynamic> toJson() {
    return {
      'staff_id': staff_id,
      'name': name,
      'department': department,
      'position': position,
      'request_type': request_type,
      'leave_count': leave_count.toDouble(),
    };
  }
}