import '../Routes/appRoutes.dart';
import 'Permission.dart';

class RolePermissions {
  static final Map<UserRole, List<String>> access = {
    UserRole.superadmin: [
      AppRoutes.overview,
      AppRoutes.dashboard,
      AppRoutes.attendance,
      AppRoutes.LeaveRequest,
      AppRoutes.employee,
      AppRoutes.department,
      AppRoutes.schedule,
      AppRoutes.employeecheckin,
      AppRoutes.employeelate,
      AppRoutes.employeeabsent,
      AppRoutes.employeeot,
      AppRoutes.employeeleavesummary,
      AppRoutes.employeeprofile,
      AppRoutes.settingmobile,
    ],
    UserRole.admin: [
      AppRoutes.overview,
      AppRoutes.dashboard,
      AppRoutes.attendance,
      AppRoutes.LeaveRequest,
      AppRoutes.employee,
      AppRoutes.department,
      AppRoutes.schedule,
      AppRoutes.employeecheckin,
      AppRoutes.employeelate,
      AppRoutes.employeeabsent,
      AppRoutes.employeeot,
      AppRoutes.employeeleavesummary,
      AppRoutes.employeeprofile,
      AppRoutes.settingmobile,
    ],
    UserRole.adminDept: [
      AppRoutes.overview,
      AppRoutes.requestleave,
      AppRoutes.userprofile,
      // AppRoutes.attendance,
      // AppRoutes.LeaveRequest,
      // AppRoutes.employee,
    ],
    UserRole.user: [
      AppRoutes.overview,
      AppRoutes.requestleave,
      AppRoutes.userprofile,

      // AppRoutes.dashboard,
      // AppRoutes.attendance,
      // AppRoutes.LeaveRequest,
      // AppRoutes.employee,
    ],
  };

  static bool canAccess(String role, String route) {
    return access[role]?.contains(route) ?? false;
  }
}
