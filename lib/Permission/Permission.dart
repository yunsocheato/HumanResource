enum UserRole { admin, adminDept, user }

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.adminDept:
        return 'admindept';
      case UserRole.user:
        return 'user';
    }
  }

  static UserRole? fromString(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'admindept':
        return UserRole.adminDept;
      case 'user':
        return UserRole.user;
      default:
        return null;
    }
  }
}
