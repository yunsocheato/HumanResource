class ApplyLeaveModel {
  final String? email;
  final String? name;
  final String? id_card;
  final String? address;
  final String? phone;
  final String? position;
  final String? department;
  final int? fingerprint_id;
  final String? Role;
  final String? photo_url;

  ApplyLeaveModel({
    required this.email,
    required this.name,
    required this.id_card,
    required this.address,
    required this.phone,
    required this.position,
    required this.department,
    required this.fingerprint_id,
    required this.Role,
    required this.photo_url,
  });

  factory ApplyLeaveModel.fromJson(Map<String, dynamic> json) {
    return ApplyLeaveModel(
      email: json['email'] as String?,
      name: json['name'] as String?,
      position: json['position'] as String?,
      department: json['department'] as String?,
      id_card: json['id_card'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      fingerprint_id: json['fingerprints_id'] as int?,
      Role: json['role'] as String?,
      photo_url: json['photo_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'position': position,
      'department': department,
      'id_card': id_card,
      'address': address,
      'phone': phone,
      'fingerprints_id': fingerprint_id,
      'Role': Role,
      'photo_url': photo_url,
    };
  }
}
