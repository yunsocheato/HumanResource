import 'package:flutter/material.dart';

class SidebarSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;

  const SidebarSection({
    required this.title,
    required this.items,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(icon, color: Colors.grey[700]),
              ],
            ),
            const Divider(),
            ...items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(item),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
