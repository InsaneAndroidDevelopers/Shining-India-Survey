import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/widgets/admin_surveyor_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/widgets/back_button.dart';

class AdminSurveyorScreen extends StatefulWidget {
  final List<Members> surveyors;
  final String teamName;
  final String teamId;
  const AdminSurveyorScreen({super.key, required this.surveyors, required this.teamName, required this.teamId});

  @override
  State<AdminSurveyorScreen> createState() => _AdminSurveyorScreenState();
}

class _AdminSurveyorScreenState extends State<AdminSurveyorScreen> {
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
                        widget.teamName,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(
                            RouteNames.adminCreateUpdateSurveyorScreen,
                            queryParameters: {
                              'isUpdate': 'false',
                              'name': '',
                              'surveyorId': '',
                              'teamId': widget.teamId,
                              'email': ''
                            },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.dividerColor
                            ),
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.add, color: AppColors.black),
                      ),
                    )
                  ],
                ),
              ),
              widget.surveyors.isEmpty
              ? Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.dividerColor,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No members present in the team\nClick on + button to add",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlack
                            ),
                          ),
                          SizedBox(height: 6,),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryBlue
                                      ),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add, color: AppColors.primaryBlue,),
                                      SizedBox(width: 2,),
                                      Text(
                                        'Add',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: AppColors.primaryBlue
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : Expanded(
                child: ListView.builder(
                  itemCount: widget.surveyors.length,
                  itemBuilder: (context, index) {
                    return AdminSurveyorWidget(
                      member: widget.surveyors[index],
                      onTap: () {
                        context.pushNamed(
                          RouteNames.adminCreateUpdateSurveyorScreen,
                          queryParameters: {
                            'isUpdate': 'true',
                            'name': widget.surveyors[index].name,
                            'surveyorId': widget.surveyors[index].surveyorId,
                            'teamId': widget.teamId,
                            'email': widget.surveyors[index].email
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
