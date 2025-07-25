import 'package:flutter/material.dart';

class RecentActivity extends StatefulWidget {
  const RecentActivity({super.key});

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
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
                      colors: [Colors.yellow.shade700, Colors.yellow.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Recent Activity',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  )),
              SizedBox(height: 10,),
              _buildcardinfo('Marry Charson Check in Late ','Today , 8:16 am ',Icons.lock_clock,Colors.blue,Colors.blue,Colors.grey),
              _buildcardinfo('Sarah Smith LeaveRequest Approved','Today, 8:45 am',Icons.time_to_leave,Colors.green,Colors.green,Colors.grey),
              _buildcardinfo('Mike Johnson','NoScan or CheckIn ',Icons.person_off,Colors.red,Colors.red,Colors.grey),
              _buildcardinfo('Mike Tyson  Request Annual Leave ','Yesterday 9:00 am',Icons.time_to_leave,Colors.yellow,Colors.yellow,Colors.grey),
              _buildcardinfo('Jessieka Orange edit her profile ','Yesterday 2:34 pm',Icons.edit,Colors.orangeAccent,Colors.orangeAccent,Colors.grey),
              _buildcardinfo('Birthday-Staff','John Son Birthday',Icons.cake,Colors.red,Colors.red,Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildcardinfo (String title ,String Subtitles , IconData icon , Color color,Color colors,Color color1){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: colors.withOpacity(0.2),
                    shape: BoxShape.circle,

                  ),
                  child: Icon(icon ,size: 15,color: color,)),
              SizedBox(width: 11,),
              Text(title,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 50,),
              child: Text(Subtitles, style: TextStyle(color: color1,fontSize: 12),))
        ],
      ),

    );
  }

}
