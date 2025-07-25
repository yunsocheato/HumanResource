import 'package:hrms/modules/Dashboard/controllers/dashboard_recently_screen_controller.dart';

List<Map<String , dynamic>> getRecentlyScreenListDistributeviewData(RecentlyControllerScreen controller) {
  return controller.users.map((user) =>
    {
      'name': user.name,
      'id_card': user.id_card,
      'position': user.position,
      'department': user.created_at,
      'icon': user.icon,
      'iconColor': user.iconColor,
      'iconBgColor': user.iconBgColor,
    }).toList();
}

