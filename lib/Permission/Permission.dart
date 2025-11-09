enum UserRole { admin, adminDept, user, superadmin }

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.superadmin:
        return 'superadmin';
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
      case 'superadmin':
        return UserRole.superadmin;
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
