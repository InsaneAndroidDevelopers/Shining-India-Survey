import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/modules/survey/ui/details_screen.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_screen.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/custom_card.dart';

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
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.transparent,
                    flexibleSpace: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      child: Text(
                        'Hi, name',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary
                        ),
                      ),
                    )
                ),
              ];
            },
            body: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
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
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
