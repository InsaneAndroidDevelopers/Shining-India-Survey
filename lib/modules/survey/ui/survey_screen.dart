import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey/ui/widgets/question_widget.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/modules/survey/ui/additional_details_screen.dart';
import 'package:shining_india_survey/surveyor/surveyor_home_screen.dart';
import '../../../models/question.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {

  final _pageController = PageController(initialPage: 0);
  int quesLength = 0;

  @override
  void initState() {
    super.initState();
    quesLength = context.read<SurveyBloc>().quesLength;
    context.read<SurveyBloc>().add(LoadFetchedDataEvent());
    print(quesLength);
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
        print(state.runtimeType);
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
                      child: Text(
                        '${context.watch<SurveyBloc>().activePage+1} / ${quesLength}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    LinearProgressIndicator(
                      minHeight: 6,
                      value: (context.watch<SurveyBloc>().activePage+1) / (quesLength),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: quesLength,
                        itemBuilder: (context, index) {
                          return QuestionWidget(
                            question: state.questions[index],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)
                        ),
                        onPressed: () {
                          context.read<SurveyBloc>().add(CheckQuestionResponseEvent(index: context.read<SurveyBloc>().activePage));
                        },
                        child: Text(
                          context.read<SurveyBloc>().activePage == quesLength - 1 ? 'Finish' : 'Next',
                          textAlign: TextAlign.center,
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
