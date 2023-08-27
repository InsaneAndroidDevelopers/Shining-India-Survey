import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey/ui/widgets/question_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {

  final _pageController = PageController(initialPage: 0);
  final pageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    context.read<SurveyBloc>().add(LoadFetchedDataEvent());
  }

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
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Error occurred'
                  )
              )
          );
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
        print("from builder - ${state.runtimeType}");
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
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      alignment: Alignment.centerRight,
                      child: ValueListenableBuilder(
                        valueListenable: pageNotifier,
                        builder: (context, value, child) {
                          return Text(
                            '${pageNotifier.value + 1} / ${state.questions.length}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: pageNotifier,
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          minHeight: 6,
                          value: (pageNotifier.value + 1) / (state.questions.length),
                        );
                      },
                    ),
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
                    SizedBox(height: 10,),
                    AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(50)
                            ),
                            onPressed: () {
                              context.read<SurveyBloc>().add(CheckQuestionResponseEvent(index: (_pageController.page ?? 0).toInt(),
                                  question: state.questions[(_pageController.page ?? 0).toInt()])
                              );
                            },
                            child: Text(
                              (_pageController.page ?? 0).toInt() == state.questions.length - 1 ? 'Finish' : 'Next',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
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
