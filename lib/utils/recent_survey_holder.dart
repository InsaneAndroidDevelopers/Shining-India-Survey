import 'package:flutter/material.dart';

import 'app_colors.dart';

class RecentSurveyHolder extends StatelessWidget {
  const RecentSurveyHolder({super.key});

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
              'username',
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
              'location',
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
              'date time',
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
