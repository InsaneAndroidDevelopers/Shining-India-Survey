import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/surveyor/additional_details_screen.dart';
import 'package:shining_india_survey/surveyor/survey_result_screen.dart';
import 'package:shining_india_survey/surveyor/surveyor_home_screen.dart';
import 'package:shining_india_survey/surveyor/widgets/question_widget.dart';
import '../models/question.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {

  final _pageController = PageController();
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    //TODO: Handle the back button

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              alignment: Alignment.centerRight,
              child: Text(
                '${_activePage+1} / ${ques.length}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            LinearProgressIndicator(
              minHeight: 6,
              value: (_activePage+1) / (ques.length),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _activePage = page;
                  });
                },
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return QuestionWidget(
                    question: ques[index],
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
                onPressed: (){
                  _activePage == ques.length-1
                    ? context.go(RouteNames.additionalDetailsScreen)
                    : _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
                child: Text(
                  _activePage == ques.length-1 ? 'Finish' : 'Next',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
