class AccessFeatureModel{
  final String userId;
  final String name;
  final String email;
  final String role;
  final String department;
  final String feature;
  final String policy;
  final String createdAt;

  AccessFeatureModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.feature,
    required this.policy,
    required this.createdAt,
  });
  factory AccessFeatureModel.fromJson(Map<String, dynamic> json) {
    return AccessFeatureModel(
      userId: json['user_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      feature: json['feature']?.toString() ?? '',
      policy: json['policy']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'department': department,
      'feature': feature,
      'policy': policy,
      'created_at': createdAt,

    };
  }
}