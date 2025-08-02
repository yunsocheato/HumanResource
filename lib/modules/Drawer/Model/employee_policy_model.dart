class employeepolicymodel{
  final String userId;
  final String name;
  final String email;
  final String department;
  final String position;
  final String idCard;
  final String password;
  final int fingerprint;
  final String phone;
  final String address;
  final String gender;
  final String dob;
  final String role;
  final String createdAt;

  employeepolicymodel({
    required this.userId,
    required this.name,
    required this.email,
    required this.department,
    required this.position,
    required this.idCard,
    required this.password,
    required this.fingerprint,
    required this.phone,
    required this.address,
    required this.gender,
    required this.dob,
    required this.role,
    required this.createdAt,
  });
  factory employeepolicymodel.fromJson(Map<String, dynamic> json) {
    return employeepolicymodel(
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      position: json['position'] ?? '',
      idCard: json['id_card'] ?? '',
      password: json['password'] ?? '',
      fingerprint: json['fingerprints_id'] ?? 0,
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'department': department,
      'position': position,
      'id_card': idCard,
      'password': password,
      'fingerprints_id': fingerprint,
      'phone': phone,
      'address': address,
      'gender': gender,
      'dob': dob,
      'role': role,
      'created_at': createdAt,
    };
  }
}