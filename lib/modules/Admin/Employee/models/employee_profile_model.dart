class EmployeeProfileModel {
  final String? user_id;
  final String? email;
  final String? name;
  final String? id_card;
  final String? address;
  final String? phone;
  final String? position;
  final String? department;
  final String? join_date;
  final String? Role;
  final String? photo_url;

  EmployeeProfileModel({
    required this.user_id,
    required this.email,
    required this.name,
    required this.id_card,
    required this.address,
    required this.phone,
    required this.position,
    required this.department,
    required this.Role,
    required this.join_date,
    required this.photo_url,
  });

  factory EmployeeProfileModel.fromMap(Map<String, dynamic> map) {
    return EmployeeProfileModel(
      user_id: map['user_id'] as String?,
      email: map['email'] as String?,
      name: map['name'] as String?,
      position: map['position'] as String?,
      department: map['department'] as String?,
      id_card: map['id_card'] as String?,
      address: map['address'] as String?,
      phone: map['phone'] as String?,
      Role: map['role'] as String?,
      photo_url: map['photo_url'] as String?,
      join_date: map['created_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'email': email,
      'name': name,
      'position': position,
      'department': department,
      'id_card': id_card,
      'address': address,
      'phone': phone,
      'Role': Role,
      'photo_url': photo_url,
      'created_at': join_date,
    };
  }
}
