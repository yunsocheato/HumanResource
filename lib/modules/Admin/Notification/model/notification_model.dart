class NotificationModel {
  final String? id;
  final String userID;
  final String title;
  final String body;
  final String? name;
  final String? department;
  String? status;
  bool? isRead;
  final String? CreatedAt;

  NotificationModel({
    required this.id,
    required this.userID,
    required this.title,
    required this.body,
    required this.name,
    required this.department,
    required this.status,
    required this.isRead,
    required this.CreatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? 'No ID',
      userID: map['user_id'] ?? 'No ID',
      isRead: map['is_read'] ?? false,
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
      'id': id,
      'user_id': userID,
      'title': title,
      'is_read': isRead,
      'body': body,
      'name': name,
      'department': department,
      'status': status,
      'created_at': CreatedAt,
    };
  }
}
