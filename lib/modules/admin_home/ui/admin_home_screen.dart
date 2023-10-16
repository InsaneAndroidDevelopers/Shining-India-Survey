import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/custom_button.dart';
import 'package:shining_india_survey/utils/custom_card.dart';
import 'package:shining_india_survey/utils/recent_survey_holder.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  final ScrollController scrollController = ScrollController();

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hi, name',
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        context.push(RouteNames.adminTeamsScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.groups_2_rounded, color: AppColors.primaryBlue,),
                            SizedBox(width: 4,),
                            Text(
                              'Teams',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryBlue
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
                          text: 'View filled surveys',
                          image: 'assets/viewfilled.png',
                          onTap: () {
                            context.push(RouteNames.adminFilledSurveys);
                          },
                        ),
                        SizedBox(height: 12,),
                        CustomCard(
                          text: 'Analysis',
                          image: 'assets/analysis.png',
                          onTap: () {
                            context.push(RouteNames.adminSurveyAnalysisScreen);
                          },
                        ),
                        SizedBox(height: 12,),
                        CustomCard(
                          text: 'Create a team',
                          image: 'assets/teams.png',
                          onTap: () {
                            context.push(RouteNames.adminTeamsScreen);
                          },
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recents',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textBlack,
                                  fontSize: 26
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                context.push(RouteNames.adminFilledSurveys);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      AppColors.primaryBlue,
                                      AppColors.primaryBlueLight,
                                    ]
                                  ),
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Text(
                                  'View all',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => RecentSurveyHolder(),
                          itemCount: 10,
                          shrinkWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      );
  }
}
