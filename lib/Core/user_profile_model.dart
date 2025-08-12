class UserProfileModel {
  final String email;
  final String name ;
  final String role ;
  final String Position ;
  late String ? image ;

  UserProfileModel({
    required this.name,
    required this.email,
    required this.image,
    required this.role,
    required this.Position,
});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      email: json['email']?.toString() ?? 'No Email',
      image: json['photo_url'],
      name: json['name'] ?? 'No Name',
      role: json['role'] ?? 'No Role',
      Position: json['position'] ?? 'No Position',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'image': image,
      'name': name,
      'role': role,
      'Position': Position,
    };
  }
}