import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/survey_detail_screen.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';

class FilledSurveyHolder extends StatelessWidget {
  final SurveyResponseModel surveyResponseModel;
  const FilledSurveyHolder({super.key, required this.surveyResponseModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(RouteNames.adminFilledSurveyDetailScreen, extra: surveyResponseModel);
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
                surveyResponseModel.personName ?? '-',
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
                '${surveyResponseModel.district}, ${surveyResponseModel.state}' ?? '-',
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
                convertDateTime(surveyResponseModel.surveyDateTime ?? ''),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
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
