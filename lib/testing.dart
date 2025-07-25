import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Always Open Drawer with AppBar',
      home: Scaffold(
        body: Column(
          children: [
            // Top AppBar
            AppBar(
              title: Text('Web Layout with Drawer'),
              backgroundColor: Colors.purple,
            ),

            // Main Content Area with Sidebar
            Expanded(
              child: Row(
                children: [
                  // Sidebar (Drawer)
                  Container(
                    width: 250,
                    color: Colors.blue.shade700,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Text(
                            'Sidebar Header',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.home, color: Colors.white),
                          title: Text(
                            'Home',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.white),
                          title: Text(
                            'Settings',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  // Main Content
                  Expanded(
                    child: Center(
                      child: Text(
                        'Main Content Area',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
