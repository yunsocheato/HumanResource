class AccessFeatureModel{
  final String name;
  final String email;
  final String role;
  final String department;
  final String feature;
  final String policy;
  final String createdAt;

  AccessFeatureModel({
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
      name: json['name'],
      email: json['email'],
      role: json['role'],
      department: json['department'],
      feature: json['feature'],
      policy: json['policy'],
      createdAt: json['created_at'],
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