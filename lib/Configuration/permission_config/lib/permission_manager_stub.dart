import 'package:permission_handler/permission_handler.dart';

Future<void> askAllPermissions() async {
  await Permission.notification.request();
  await Permission.location.request();
  await Permission.storage.request();
  await Permission.photos.request();
}

Future<void> requestWebNotificationPermission() async {}
Future<void> requestWebLocationPermission() async {}
Future<void> requestWebStoragePermission() async {}
Future<void> requestWebPhotoPermission() async {}
