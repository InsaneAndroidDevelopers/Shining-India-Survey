import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/custom_card.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
                      text: 'View filled surveys',
                      image: 'assets/viewfilled.png',
                      onTap: () {
                        context.push(RouteNames.detailsScreen);
                      },
                    ),
                    SizedBox(height: 16,),
                    CustomCard(
                      text: 'Analysis',
                      image: 'assets/analysis.png',
                      onTap: () {
                        context.push(RouteNames.adminSurveyAnalysisScreen);
                      },
                    ),
                    SizedBox(height: 16,),
                    CustomCard(
                      text: 'Create a team',
                      image: 'assets/teams.png',
                      onTap: () {
                        context.push(RouteNames.adminTeamsScreen);
                      },
                    ),
                    SizedBox(height: 16,),
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
