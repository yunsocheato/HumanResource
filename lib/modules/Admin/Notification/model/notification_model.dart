class NotificationModel {
  final String userID;
  final String title;
  final String body;
  final String? name;
  final String? department;
  final String status;
  final String? CreatedAt;

  NotificationModel({
    required this.userID,
    required this.title,
    required this.body,
    required this.name,
    required this.department,
    required this.status,
    required this.CreatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      userID: map['user_id'] ?? 'No ID',
      title: map['title'] ?? 'No title',
      body: map['body'] ?? 'No body',
      name: map['name'] ?? 'No name',
      department: map['department'] ?? 'No department',
      status: map['status'] ?? 'No status',
      CreatedAt: map['created_at'] ?? 'No date',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userID,
      'title': title,
      'body': body,
      'name': name,
      'department': department,
      'status': status,
      'created_at': CreatedAt,
    };
  }
}
