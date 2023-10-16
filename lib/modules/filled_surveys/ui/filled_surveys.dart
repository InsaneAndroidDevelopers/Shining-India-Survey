import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:shining_india_survey/utils/recent_survey_holder.dart';

class AdminFilledSurveys extends StatefulWidget {
  const AdminFilledSurveys({super.key});

  @override
  State<AdminFilledSurveys> createState() => _AdminFilledSurveysState();
}

class _AdminFilledSurveysState extends State<AdminFilledSurveys> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBackButton(
                      onTap: (){
                        context.pop();
                      },
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Text(
                        'All Surveys',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => RecentSurveyHolder(),
                  itemCount: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
