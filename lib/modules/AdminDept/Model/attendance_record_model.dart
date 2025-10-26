class AttendanceRecordModel {
  final String name;
  final DateTime? date;
  final String check_type;
  final String department;

  AttendanceRecordModel({
    required this.name,
    required this.date,
    required this.check_type,
    required this.department,
  });

  factory AttendanceRecordModel.fromMap(Map<String, dynamic> map) {
    return AttendanceRecordModel(
      name: map['username'],
      date: _tryParseDate(map['timestamp']),
      check_type: map['check_type'],
      department: map['department'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date,
      'check_type': check_type,
      'department': department,
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
