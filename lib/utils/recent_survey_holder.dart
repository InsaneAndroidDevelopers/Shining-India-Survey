import 'package:flutter/material.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/models/surveyor_home_reponse_model.dart';

import 'app_colors.dart';

class RecentSurveyHolder extends StatelessWidget {
  final SurveyorHomeResponseModel surveyorHomeResponseModel;
  const RecentSurveyHolder({super.key, required this.surveyorHomeResponseModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.primaryBlueBackground
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.person_2_rounded,
            color: AppColors.primaryBlue
          ),
          SizedBox(width: 4,),
          Expanded(
            child: Text(
              surveyorHomeResponseModel.personName ?? '-',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: AppColors.textBlack,
              ),
            ),
          ),
          SizedBox(width: 4,),
          Expanded(
            child: Text(
              '${surveyorHomeResponseModel.address}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: AppColors.textBlack,
              ),
            ),
          ),
          SizedBox(width: 4,),
          Expanded(
            child: Text(
              surveyorHomeResponseModel.surveyDateTime ?? '-',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: AppColors.textBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
