import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/widgets/admin_surveyor_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/back_button.dart';

class AdminSurveyorScreen extends StatefulWidget {
  const AdminSurveyorScreen({super.key});

  @override
  State<AdminSurveyorScreen> createState() => _AdminSurveyorScreenState();
}

class _AdminSurveyorScreenState extends State<AdminSurveyorScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        'Team name',
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
                              'name': ''
                            }
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
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return AdminSurveyorWidget(
                      onTap: () {
                        context.pushNamed(
                          RouteNames.adminCreateUpdateSurveyorScreen,
                          queryParameters: {
                            'isUpdate': 'true',
                            'name': 'Dummy'
                          }
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
