class LeaveRequestModel {
  final String id;
  final String name;
  final String userEmail;
  final String department;
  final String position;
  final String status;
  final DateTime? fromDate;
  final DateTime? toDate;

  LeaveRequestModel({
    required this.id,
    required this.name,
    required this.userEmail,
    required this.department,
    required this.position,
    required this.status,
    this.fromDate,
    this.toDate,
  });

  factory LeaveRequestModel.fromMap(Map<String, dynamic> map) {
    return LeaveRequestModel(
      id: map['request_id'] ?? '',
      name: map['name'] ?? '-',
      userEmail: map['email'] ?? '-',
      department: map['department'] ?? '-',
      position: map['position'] ?? '-',
      status: map['status'] ?? '-',
      fromDate:
          map['from_date'] != null ? DateTime.parse(map['from_date']) : null,
      toDate: map['to_date'] != null ? DateTime.parse(map['to_date']) : null,
    );
  }
}
