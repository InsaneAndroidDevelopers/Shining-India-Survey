import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';

class AdminTeamWidget extends StatelessWidget {
  final TeamModel teamModel;
  const AdminTeamWidget({super.key, required this.teamModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(RouteNames.adminSurveyorsScreen, extra: {'surveyors': teamModel.members, 'teamName': teamModel.teamName, 'teamId': teamModel.id});
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryBlueLight,
          borderRadius: BorderRadius.circular(14)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.groups_2_rounded, color: AppColors.primaryBlue,),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    teamModel.teamName ?? '-',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    '${teamModel.members?.length} members',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.textBlack,
                    ),
                  )
                ],
              )
            ),
            SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle
              ),
              child: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primaryBlue, size: 18,),
            )
          ],
        ),
      ),
    );
  }
}
