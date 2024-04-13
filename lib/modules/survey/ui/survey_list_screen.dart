import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/global/widgets/custom_button.dart';
import 'package:shining_india_survey/global/widgets/custom_flushbar.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey/ui/widgets/question_list_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';

class SurveyListScreen extends StatefulWidget {
  const SurveyListScreen({super.key});

  @override
  State<SurveyListScreen> createState() => _SurveyListScreenState();
}

class _SurveyListScreenState extends State<SurveyListScreen>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocConsumer<SurveyBloc, SurveyState>(
          listener: (context, state) {
            if(state is SurveyErrorState){
              CustomFlushBar(
                message: state.message,
                context: context,
                icon: const Icon(Icons.cancel_outlined, color: AppColors.primary),
                backgroundColor: Colors.red
              ).show();
            } else if(state is SurveyFinishState) {
              context.go(RouteNames.additionalDetailsScreen);
            }
          },
          builder: (context, state) {
            if(state is SurveyLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is SurveyDataLoadedState) {
              return WillPopScope(
                  onWillPop: () async {
                return await showDialog(
                  context: context,
                  builder: (context) =>
                      AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Do you want to exit the survey'),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(false),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.go(RouteNames.surveyorHomeScreen),
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                ) ?? false;
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.questions.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return QuestionListWidget(
                            question: state.questions[index],
                          );
                        },
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      onTap: () {
                        context.read<SurveyBloc>().add(SkipQuestionEvent(
                            index: state.questions.length-1,
                            question: state.questions[state.questions.length-1]
                          )
                        );
                      },
                      child: const Text(
                        'Finish',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ],
              )
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
