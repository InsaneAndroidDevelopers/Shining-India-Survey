import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminSurveyorWidget extends StatefulWidget {
  final VoidCallback onTap;
  const AdminSurveyorWidget({super.key, required this.onTap});

  @override
  State<AdminSurveyorWidget> createState() => _AdminSurveyorWidgetState();
}

class _AdminSurveyorWidgetState extends State<AdminSurveyorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 8,),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                SizedBox(height: 4,),
                Text('Email')
              ],
            ),
          ),
          SizedBox(width: 10,),
          CircleAvatar(
            backgroundColor: Colors.green,
            maxRadius: 8,
          ),
          SizedBox(width: 20,),
          IconButton(
            onPressed: () {
              widget.onTap();
            },
            icon: Icon(Icons.edit)
          )
        ],
      ),
    );
  }
}
