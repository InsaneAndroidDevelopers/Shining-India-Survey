import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/modules/survey/ui/details_screen.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_screen.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/custom_card.dart';
import 'package:shining_india_survey/utils/recent_survey_holder.dart';

class SurveyorHomeScreen extends StatefulWidget {
  const SurveyorHomeScreen({super.key});

  @override
  State<SurveyorHomeScreen> createState() => _SurveyorHomeScreenState();
}

class _SurveyorHomeScreenState extends State<SurveyorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Text(
                'Hi, name',
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 18, left: 14, right: 14),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24))
                ),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCard(
                        text: 'Take a survey',
                        image: 'assets/takesurvey.png',
                        onTap: () {
                          context.push(RouteNames.detailsScreen);
                        },
                      ),
                      SizedBox(height: 14,),
                      Text(
                        'Recents',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          color: AppColors.textBlack,
                          fontSize: 26
                        ),
                      ),
                      SizedBox(height: 20,),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => RecentSurveyHolder(),
                        itemCount: 20,
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
