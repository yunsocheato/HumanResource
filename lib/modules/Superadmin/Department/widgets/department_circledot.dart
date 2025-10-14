import 'package:flutter/material.dart';

class Circledot extends StatelessWidget {
  final Map<String, double> dataMap;

  const Circledot({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          dataMap.entries.map((entry) {
            Color color;
            switch (entry.key) {
              case "IT":
                color = Colors.blue;
                break;
              case "HR":
                color = Colors.blueAccent;
                break;
              case "Finance":
                color = Colors.blue.shade900;
                break;
              case "Admin":
                color = Colors.yellow;
                break;
              case "ATM":
                color = Colors.orangeAccent;
                break;
              case "Stock":
                color = Colors.green;
              default:
                color = Colors.grey;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(entry.key, style: TextStyle(fontSize: 16)),
                  SizedBox(width: 8),
                  Text(
                    entry.value.toInt().toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
