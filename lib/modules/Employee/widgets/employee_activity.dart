  import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
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
                      colors: [Colors.green.shade700, Colors.green.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent Activity',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                        TextButton(onPressed: (){}, child: Text('View all',style: TextStyle(color: Colors.blue),))
                      ],
                    ),
                  )
              ),
              SizedBox(height: 10,),
              _buildcardinfo('Marry Checked in at 8:45am ','Today , 8:16 am ',Icons.check,Colors.blue,Colors.blue,Colors.grey),
              _buildcardinfo('SarahLeaveRequest Approved','Today, 8:45 am',Icons.calendar_month,Colors.green,Colors.green,Colors.grey),
              _buildcardinfo('Mike Late Arrival','Monday,9:15 am ',Icons.alarm,Colors.yellow,Colors.yellow,Colors.grey),
              _buildcardinfo('You was Exported Attandance','Last Friday,9:00 am',Icons.file_copy,Colors.deepOrange,Colors.deepOrange,Colors.grey),
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
