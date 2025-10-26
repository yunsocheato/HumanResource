class LeaveRecordModel {
  final String name;
  final String leavereason;
  final String department;
  final String position;
  final String status;
  final String submitrole;
  final String CreatAt;
  final DateTime? fromDate;
  final DateTime? toDate;

  LeaveRecordModel({
    required this.name,
    required this.leavereason,
    required this.department,
    required this.position,
    required this.status,
    required this.CreatAt,
    required this.submitrole,
    this.fromDate,
    this.toDate,
  });

  factory LeaveRecordModel.fromMap(Map<String, dynamic> map) {
    return LeaveRecordModel(
      name: map['name'] ?? '-',
      leavereason: map['reason'] ?? '-',
      department: map['department'] ?? '-',
      position: map['job_position'] ?? '-',
      status: map['status'] ?? '-',
      submitrole: map['submitted_to_role'] ?? '-',
      CreatAt: map['created_at'] ?? '-',
      fromDate: _tryParseDate(map['from_date']),
      toDate: _tryParseDate(map['to_date']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'reason': leavereason,
      'department': department,
      'job_position': position,
      'status': status,
      'submitted_to_role': submitrole,
      'created_at': CreatAt,
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
