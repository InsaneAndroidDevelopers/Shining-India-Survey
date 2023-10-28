import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shining_india_survey/helpers/shared_pref_helper.dart';
import 'package:shining_india_survey/modules/splash/core/bloc/splash_bloc.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/bloc/surveyor_home_bloc.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/modules/survey/ui/details_screen.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_screen.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/custom_card.dart';
import 'package:shining_india_survey/utils/custom_flushbar.dart';
import 'package:shining_india_survey/utils/custom_loader.dart';
import 'package:shining_india_survey/utils/recent_survey_holder.dart';

class SurveyorHomeScreen extends StatefulWidget {
  const SurveyorHomeScreen({super.key});

  @override
  State<SurveyorHomeScreen> createState() => _SurveyorHomeScreenState();
}

class _SurveyorHomeScreenState extends State<SurveyorHomeScreen> {
  ValueNotifier<String> username = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    context.read<SurveyorHomeBloc>().add(GetSurveyorInfo());
    context.read<SurveyorHomeBloc>().add(GetRecentSurveys());
  }

  @override
  Widget build(BuildContext buildContext) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: BlocListener<SurveyorHomeBloc, SurveyorHomeState>(
          listenWhen: (previous, current) {
            if(previous is SurveyorLogoutLoadingState) {
              context.pop();
            }
            return true;
          },
          listener: (context, state) {
            if(state is SurveyorLogoutLoadingState) {
              CustomLoader(context: context).show();
            } else if(state is SurveyorLogoutSuccessState) {
              context.go(RouteNames.loginScreen);
            } else if(state is SurveyorLogoutErrorState) {
              CustomFlushBar(
                message: state.message,
                icon: Icon(Icons.cancel_outlined, color: AppColors.primary,),
                backgroundColor: Colors.red,
                context: context
              ).show();
            } else if(state is SurveyorHomeInfoFetchedState) {
              username.value = state.name;
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
                                fontSize: 28,
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
                        context.read<SurveyorHomeBloc>().add(SurveyorLogout());
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.logout_rounded, color: AppColors
                                .primaryBlue,),
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
                  padding: const EdgeInsets.only(top: 18, left: 14, right: 14),
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
                          text: 'Take a survey',
                          image: 'assets/takesurvey.png',
                          onTap: () {
                            buildContext.push(RouteNames.detailsScreen);
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
                        BlocBuilder<SurveyorHomeBloc, SurveyorHomeState>(
                          buildWhen: (previous, current) {
                            switch(current.runtimeType){
                              case SurveyorHomeFetchedState:
                              case SurveyorHomeErrorState:
                              case SurveyorHomeLoadingState:
                                return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            if (state is SurveyorHomeLoadingState) {
                              return Center(
                                child: Lottie.asset(
                                  'assets/loading.json',
                                  width: 150,
                                  height: 150,
                                ),
                              );
                            } else if (state is SurveyorHomeErrorState) {
                              return Container(
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
                                    Icon(Icons.error_outline_outlined, color: AppColors.primaryBlue, size: 50),
                                    Text(
                                      state.message,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textBlack
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context.read<SurveyorHomeBloc>().add(
                                                GetRecentSurveys());
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
                                              'Try Again',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            } else if (state is SurveyorHomeFetchedState) {
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    RecentSurveyHolder(recentSurveyHolder: state.surveys[index]),
                                itemCount: state.surveys.length,
                                shrinkWrap: true,
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
