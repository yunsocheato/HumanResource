class UserProfileModel {
  final String name;
  final String role;
  final String Position;
  late String image;

  UserProfileModel({
    required this.name,
    required this.image,
    required this.role,
    required this.Position,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      image: map['photo_url'] ?? 'No Image',
      name: map['name'] ?? 'No Name',
      role: map['role'] ?? 'No Role',
      Position: map['position'] ?? 'No Position',
    );
  }

  Map<String, dynamic> toMap() {
    return {'image': image, 'name': name, 'role': role, 'Position': Position};
  }
}
