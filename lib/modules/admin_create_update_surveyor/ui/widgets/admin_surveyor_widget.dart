import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/utils/app_colors.dart';

class AdminSurveyorWidget extends StatefulWidget {
  final Members member;
  final VoidCallback onTap;
  const AdminSurveyorWidget({super.key, required this.onTap, required this.member});

  @override
  State<AdminSurveyorWidget> createState() => _AdminSurveyorWidgetState();
}

class _AdminSurveyorWidgetState extends State<AdminSurveyorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.primaryBlueLight,
          borderRadius: BorderRadius.circular(14)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.person_2_rounded,
            color: AppColors.primaryBlue
          ),
          SizedBox(width: 20),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.member.name ?? '-',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    widget.member.email ?? '-',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.textBlack,
                    ),
                  )
                ],
              )
          ),
          SizedBox(width: 10,),
          Column(
            children: [
              CircleAvatar(
                backgroundColor: widget.member.active==true ? AppColors.green : Colors.red,
                maxRadius: 8,
              ),
              Text(
                widget.member.active==true ? 'Active' : 'Inactive',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
          SizedBox(width: 20,),
          InkWell(
            onTap: (){
              widget.onTap();
            },
            child: Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle
              ),
              child: Icon(Icons.edit, color: AppColors.primaryBlue),
            ),
          )
        ],
      ),
    );
  }
}
