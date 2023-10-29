import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey/ui/widgets/question_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/custom_button.dart';
import 'package:shining_india_survey/utils/custom_flushbar.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {

  final _pageController = PageController(initialPage: 0);
  final pageNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SurveyBloc, SurveyState>(
      listener: (context, state) {
        if(state is SurveyErrorState){
          CustomFlushBar(
            message: state.message,
            context: context,
            icon: Icon(Icons.cancel_outlined, color: AppColors.primary),
            backgroundColor: Colors.red
          ).show();
        } else if(state is SurveyFinishState) {
          context.go(RouteNames.additionalDetailsScreen);
        } else if(state is SurveyMoveNextQuestionState) {
          _pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
          pageNotifier.value++;
        }
      },
      buildWhen: (previous, current) {
        switch(current.runtimeType){
          case SurveyLoadingState:
          case SurveyDataLoadedState:
            return true;
          default: return false;
        }
      },
      builder: (context, state) {
        if(state is SurveyLoadingState){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if(state is SurveyDataLoadedState){
          return WillPopScope(
            onWillPop: () async {
              return await showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text('Are you sure?'),
                      content: Text('Do you want to exit the survey'),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(false),
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.go(RouteNames.surveyorHomeScreen),
                          child: Text('Yes'),
                        ),
                      ],
                    ),
              ) ?? false;
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.primary,
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                    title: Text('Are you sure?'),
                                    content: Text('Do you want to exit the survey'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => context.pop(false),
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            context.go(RouteNames.surveyorHomeScreen),
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ),
                              );
                            },
                            child: Icon(Icons.cancel_outlined,)
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.dividerColor,
                                ),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ValueListenableBuilder(
                                      valueListenable: pageNotifier,
                                      builder: (context, value, child) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: SizedBox(
                                            height: 8,
                                            child: LinearProgressIndicator(
                                              value: (pageNotifier.value + 1) / (state.questions.length),
                                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                                              backgroundColor: AppColors.primaryBlueBackground,
                                            ),
                                          ),
                                        );
                                      },
                                    ), //
                                  ),
                                  SizedBox(width: 8,),
                                  ValueListenableBuilder(
                                    valueListenable: pageNotifier,
                                    builder: (context, value, child) {
                                      return Text(
                                        '${((pageNotifier.value + 1) / (state.questions.length) * 100).toInt().toString()}%',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w700
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff03738c),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                controller: _pageController,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.questions.length,
                                itemBuilder: (context, index) {
                                  return QuestionWidget(
                                    question: state.questions[index],
                                  );
                                },
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _pageController,
                              builder: (context, child) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  child: CustomButton(
                                    onTap: () {
                                      context.read<SurveyBloc>().add(CheckQuestionResponseEvent(
                                          index: (_pageController.page ?? 0).toInt(),
                                          question: state.questions[(_pageController.page ?? 0).toInt()]
                                        )
                                      );
                                    },
                                    text: (_pageController.page ?? 0).toInt() == state.questions.length - 1 ? 'Finish' : 'Next',
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10,)
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
        return Container();
      },
    );
  }
}
