import 'package:flutter/material.dart';
import 'package:shining_india_survey/surveyor/surveyor_home_screen.dart';
import 'package:shining_india_survey/surveyor/widgets/animated_prompt.dart';

class SurveyResultScreen extends StatefulWidget {
  const SurveyResultScreen({super.key});

  @override
  State<SurveyResultScreen> createState() => _SurveyResultScreenState();
}

class _SurveyResultScreenState extends State<SurveyResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedPrompt(
            title: 'Your survey has been submitted',
            onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SurveyorHomeScreen()), (route) => false);
            }
          ),
        ),
      ),
    );
  }
}
