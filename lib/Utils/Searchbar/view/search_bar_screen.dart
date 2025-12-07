import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/search_bar_controller.dart';

class SearchbarScreen extends GetView<SearchBarController> {
  const SearchbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSearchBoxResponsives();
  }

  Widget _buildSearchBoxResponsives() {
    final isMobile = Get.width < 600;
    return isMobile ? _buildSearchBoxMobile() : _buildSearchBoxOther();
  }

  Widget _buildSearchBoxMobile() {
    final searchController = Get.find<SearchBarController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.withOpacity(0.5),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.white70),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          searchController.search(value);
        },
      ),
    );
  }

  Widget _buildSearchBoxOther() {
    final searchController = Get.find<SearchBarController>();
    return SizedBox(
      height: 35,
      width: 250,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.withOpacity(0.5),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.white70),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          searchController.search(value);
        },
      ),
    );
  }
}
