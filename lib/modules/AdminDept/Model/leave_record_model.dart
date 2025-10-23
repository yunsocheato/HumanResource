class LeaveRequestModel {
  final String name;
  final String leavereason;
  final String department;
  final String position;
  final String status;
  final String submitrole;
  final DateTime? fromDate;
  final DateTime? toDate;

  LeaveRequestModel({
    required this.name,
    required this.leavereason,
    required this.department,
    required this.position,
    required this.status,
    required this.submitrole,
    this.fromDate,
    this.toDate,
  });

  factory LeaveRequestModel.fromMap(Map<String, dynamic> map) {
    return LeaveRequestModel(
      name: map['name'] ?? '-',
      leavereason: map['leave_reason'] ?? '-',
      department: map['department'] ?? '-',
      position: map['position'] ?? '-',
      status: map['status'] ?? '-',
      submitrole: map['submitted_to_role'] ?? '-',
      fromDate: _tryParseDate(map['from_date']),
      toDate: _tryParseDate(map['to_date']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'leave_reason': leavereason,
      'department': department,
      'position': position,
      'status': status,
      'submitted_to_role': submitrole,
      'from_date': fromDate?.toIso8601String(),
      'to_date': toDate?.toIso8601String(),
    };
  }

  static DateTime? _tryParseDate(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return null;
    }
  }
}
