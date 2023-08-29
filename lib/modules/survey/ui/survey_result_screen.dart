import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/modules/survey/ui/widgets/animated_prompt.dart';

class SurveyResultScreen extends StatefulWidget {
  const SurveyResultScreen({super.key});

  @override
  State<SurveyResultScreen> createState() => _SurveyResultScreenState();
}

class _SurveyResultScreenState extends State<SurveyResultScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: AnimatedPrompt(
              title: 'Your survey has been submitted',
              onTap: (){
                context.go(RouteNames.surveyorHomeScreen);
              }
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    context.go(RouteNames.surveyorHomeScreen);
    return false;
  }
}
