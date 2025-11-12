import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});
  static const routeName = '/logout';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.pink.shade300,
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, size: 60, color: Colors.black),
              const SizedBox(height: 20),
              Text(
                'You are Logout Successful',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Note: All Your Data and Cache will delete After You are logout Successful',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Get.offAllNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  'Return Login ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none, // <--- add this
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
