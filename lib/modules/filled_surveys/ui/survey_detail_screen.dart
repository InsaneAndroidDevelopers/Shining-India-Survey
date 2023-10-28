import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/filled_surveys/widgets/survey_detail_holder.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/back_button.dart';

class SurveyDetailScreen extends StatelessWidget {
  const SurveyDetailScreen({super.key});

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
                      onTap: () {
                        context.pop();
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        'Details',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlueBackground,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            SurveyDetailHolder(
                              name: 'Name',
                              val: 'Ram Prakagergjeqriubfberiubfverwkbviuerofvberiobgfvieorbviebiufrbkjrbfvkbtrgvioeutoibtreioish',
                            ),
                            Divider(color: AppColors.dividerColor,),
                            SurveyDetailHolder(
                              name: 'Name',
                              val: 'Ram Prakagergjeqriubfberiubfverwkbviuerofvberiobgfvieorbviebiufrbkjrbfvkbtrgvioeutoibtreioish',
                            ),
                            Divider(color: AppColors.dividerColor,),
                            SurveyDetailHolder(
                              name: 'Name',
                              val: 'Ram Prakagergjeqriubfberiubfverwkbviuerofvberiobgfvieorbviebiufrbkjrbfvkbtrgvioeutoibtreioish',
                            ),
                            Divider(color: AppColors.dividerColor,),
                            SurveyDetailHolder(
                              name: 'Name',
                              val: 'Ram Prakagergjeqriubfberiubfverwkbviuerofvberiobgfvieorbviebiufrbkjrbfvkbtrgvioeutoibtreioish',
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
