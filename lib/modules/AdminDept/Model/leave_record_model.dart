class LeaveRecordModel {
  final String? photo_url;
  final String id;
  final String userId;
  final String name;
  final String department;
  final String position;
  final String reason;
  final List<Approver> approvedBy;
  final String location;
  final String requestNumber;
  final DateTime? requestDate;
  final double? leaveCount;
  final String requestType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final String currentStage;
  final String? reviewedBy;
  final String? actionBy;
  final String? actionByRole;

  LeaveRecordModel({
    required this.photo_url,
    required this.id,
    required this.userId,
    required this.name,
    required this.approvedBy,
    required this.department,
    required this.position,
    required this.reason,
    required this.location,
    required this.requestNumber,
    required this.requestDate,
    required this.leaveCount,
    required this.requestType,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.currentStage,
    required this.reviewedBy,
    required this.actionBy,
    required this.actionByRole,
  });

  factory LeaveRecordModel.fromMap(Map<String, dynamic> map) {
    List<Approver> approvers = [];
    if (map['approved_by'] != null) {
      final list = map['approved_by'] as List<dynamic>;
      approvers = list.map((e) => Approver.fromMap(e)).toList();
    }

    return LeaveRecordModel(
      photo_url: map['photo_url'],
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      name: map['name'] ?? '',
      approvedBy: approvers,
      department: map['department'] ?? '',
      position: map['position'] ?? '',
      reason: map['reason'] ?? '',
      location: map['location'] ?? '',
      requestNumber: map['request_number'] ?? '',
      requestDate: _tryParseDate(map['request_date']),
      leaveCount: _tryParseDouble(map['leave_count']),
      requestType: map['request_type'] ?? '',
      startDate: _tryParseDate(map['start_date']),
      endDate: _tryParseDate(map['end_date']),
      status: map['status'] ?? '-',
      currentStage: map['current_stage'] ?? '-',
      reviewedBy: map['reviewed_by'],
      actionBy: map['action_by'],
      actionByRole: map['action_by_role'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'approved_by': approvedBy.map((a) => a.toMap()).toList(),
      'department': department,
      'position': position,
      'reason': reason,
      'location': location,
      'photo_url': photo_url,
      'request_number': requestNumber,
      'request_date': requestDate?.toIso8601String(),
      'leave_count': leaveCount,
      'request_type': requestType,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
      'current_stage': currentStage,
      'reviewed_by': reviewedBy,
      'action_by': actionBy,
      'action_by_role': actionByRole,
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

  static double? _tryParseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    try {
      return double.parse(value.toString());
    } catch (_) {
      return null;
    }
  }
}

//another model for Data Profile Approver
class Approver {
  final String name;
  final String? photo_url;
  final String? role;

  Approver({required this.name, this.photo_url, this.role});

  factory Approver.fromMap(Map<String, dynamic> map) {
    return Approver(
      name: map['name'] ?? '',
      photo_url: map['photo_url'] ?? '',
      role: map['role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'photo_url': photo_url, 'role': role};
  }
}
