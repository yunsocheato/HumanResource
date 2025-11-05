class RequestLeaveModel {
  final String id;
  final String userId;
  final String name;
  final String department;
  final String position;
  final String reason;
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

  RequestLeaveModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.department,
    required this.position,
    required this.reason,
    required this.location,
    required this.requestNumber,
    this.requestDate,
    this.leaveCount,
    required this.requestType,
    this.startDate,
    this.endDate,
    required this.status,
    required this.currentStage,
    this.reviewedBy,
    this.actionBy,
    this.actionByRole,
  });

  factory RequestLeaveModel.fromMap(Map<String, dynamic> map) {
    return RequestLeaveModel(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'] ?? '',
      department: map['department'] ?? '',
      position: map['position'] ?? '',
      reason: map['reason'] ?? '',
      location: map['location'] ?? '',
      requestNumber: map['request_number'] ?? '',
      requestDate: map['request_date'] != null
          ? DateTime.parse(map['request_date'])
          : null,
      leaveCount: map['leave_count']?.toDouble(),
      requestType: map['request_type'] ?? '',
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date'])
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date'])
          : null,
      status: map['status'] ?? 'pending',
      currentStage: map['current_stage'] ?? 'admindept',
      reviewedBy: map['reviewed_by'],
      actionBy: map['action_by'],
      actionByRole: map['action_by_role'],
    );
  }
}


// final response = await supabase
//     .from('leave_requests')
// .select()
//     .eq('user_id', currentUserId)  // Only their own requests
//     .order('created_at', ascending: false);
// String getStatusLabel(String status) {
//   switch (status) {
//     case 'pending_admindept':
//       return "Waiting for Admin Dept";
//     case 'pending_admin':
//       return "Reviewing by HR";
//     case 'pending_superadmin':
//       return "Reviewing by Superadmin";
//     case 'approved':
//       return "Approved";
//     case 'rejected':
//       return "Rejected";
//     default:
//       return status;
//   }
// }
// Text(
// getStatusLabel(request.status),
// style: TextStyle(
// color: request.status == 'approved'
// ? Colors.green
//     : request.status == 'rejected'
// ? Colors.red
//     : Colors.orange,
// ),
// )

