import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/models/recent_survey_model.dart';
import 'package:shining_india_survey/routes/routes.dart';
import '../../../../global/values/app_colors.dart';

class RecentSurveyHolder extends StatelessWidget {
  final RecentSurveyModel recentSurveyHolder;
  const RecentSurveyHolder({super.key, required this.recentSurveyHolder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.surveyorMapDetailsScreen, queryParameters: {
          'latitude': recentSurveyHolder.latitude ?? '0.00',
          'longitude': recentSurveyHolder.longitude ?? '0.00'
        });
      },
      child: Container(
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
                recentSurveyHolder.name ?? '-',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.textBlack,
                ),
              ),
            ),
            SizedBox(width: 4,),
            Expanded(
              child: Text(
                '${recentSurveyHolder.district}, ${recentSurveyHolder.state}' ?? '-',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.textBlack,
                ),
              ),
            ),
            SizedBox(width: 4,),
            Expanded(
              child: Text(
                convertDateTime(recentSurveyHolder.time ?? ''),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.textBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertDateTime(String isoString) {
    if(isoString.isEmpty) {
      return '-';
    }
    DateFormat customDateFormat = DateFormat('MMM dd, yyyy, HH:mm a');
    DateTime isoDate = DateTime.parse(isoString);
    String customFormattedDate = customDateFormat.format(isoDate);
    return customFormattedDate;
  }
}
