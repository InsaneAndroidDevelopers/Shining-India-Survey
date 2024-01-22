import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:shining_india_survey/global/values/string_constants.dart';
import 'package:shining_india_survey/helpers/hive_db_helper.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_home/core/bloc/admin_home_bloc.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/models/recent_survey_model.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/widgets/custom_button.dart';
import 'package:shining_india_survey/global/widgets/custom_card.dart';
import 'package:shining_india_survey/global/widgets/custom_flushbar.dart';
import 'package:shining_india_survey/modules/surveyor_home/ui/widgets/recent_survey_holder.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  ValueNotifier<String> username = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    context.read<AdminHomeBloc>().add(GetAdminInfo());
  }

  @override
  Widget build(BuildContext context) {
    print(HiveDbHelper.getBox().get('659054dfcf111b03a0d182ed'));
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.primaryBlue,
          body: BlocListener<AdminHomeBloc, AdminHomeState>(
            listener: (context, state) {
              if(state is AdminHomeInfoFetchedState) {
                username.value = state.name;
              } else if(state is AdminHomeLogoutSuccess) {
                context.go(RouteNames.loginScreen);
              } if(state is AdminHomeLogoutError) {
                CustomFlushBar(
                  context: context,
                  message: state.message,
                  icon: Icon(Icons.cancel_outlined, color: AppColors.primary,),
                  backgroundColor: Colors.red
                ).show();
              }
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: username,
                          builder: (context, value, child) {
                            return Text(
                              'Hi, ${username.value}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<AdminHomeBloc>().add(AdminLogout());
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.logout_rounded,
                                color: AppColors.primaryBlue,),
                              SizedBox(width: 2,),
                              Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 12,
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
                    padding: const EdgeInsets.only(
                        top: 18, left: 14, right: 14),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24))
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
                              context.push(RouteNames.adminFilledSurveysScreen);
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
                          SizedBox(height: 12,),
                          CustomCard(
                            text: 'Create a surveyor',
                            image: 'assets/teams.png',
                            onTap: () {
                              context.pushNamed(
                                  RouteNames.adminCreateUpdateSurveyorScreen,
                                  queryParameters: {
                                    'isUpdate': 'false',
                                    'name': '',
                                    'surveyorId': '',
                                    'teamId': '',
                                    'email': ''
                                  },
                              );
                            },
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
