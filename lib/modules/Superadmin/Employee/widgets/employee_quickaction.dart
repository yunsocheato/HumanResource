import 'package:flutter/material.dart';

class QuickAction extends StatefulWidget {
  const QuickAction({super.key});

  @override
  State<QuickAction> createState() => _QuickActionState();
}

class _QuickActionState extends State<QuickAction> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 450,
      child:Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.deepPurpleAccent.shade700, Colors.deepPurpleAccent.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quick Actions',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                        TextButton(onPressed: (){}, child: Text('View all',style: TextStyle(color: Colors.blue),))
                      ],
                    ),
                  )
              ),
                 SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.8,
                      children: [
                      _buildActionBox(
                        icon: Icons.calendar_today,
                        label: "Request Leave",
                        iconColor: Colors.blue.shade700,
                        bgColor: Colors.blue.shade100,
                      ),
                      _buildActionBox(
                        icon: Icons.access_time,
                        label: "Time Off",
                        iconColor: Colors.green.shade700,
                        bgColor: Colors.green.shade100,
                      ),
                      _buildActionBox(
                        icon: Icons.file_upload,
                        label: "Export Data",
                        iconColor: Colors.purple.shade700,
                        bgColor: Colors.purple.shade100,
                      ),
                      _buildActionBox(
                        icon: Icons.person,
                        label: "Update Profile",
                        iconColor: Colors.amber.shade800,
                        bgColor: Colors.amber.shade100,
                      ),
                    ],
                                    ),
                  ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upcoming Holidays',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10,),
                      _buildHolidayTile(
                        title: "New Year's Day",
                        date: "Jan 1, 2024",
                        icon: Icons.calendar_today,
                        iconColor: Colors.blue.shade700,
                        tileColor: Colors.blue.shade50,
                      ),
                      _buildHolidayTile(
                        title: "Labor Day",
                        date: "May 1, 2024",
                        icon: Icons.calendar_today,
                        iconColor: Colors.green.shade700,
                        tileColor: Colors.green.shade50,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
      )
        );
  }

  Widget _buildActionBox({
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color bgColor,
  }) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.yellow),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: bgColor,
              radius: 18,
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHolidayTile({
    required String title,
    required String date,
    required IconData icon,
    required Color iconColor,
    required Color tileColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 16,
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              Text(date,
                  style: const TextStyle(
                      color: Colors.black54, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
