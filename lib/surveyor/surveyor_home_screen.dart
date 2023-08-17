import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/surveyor/details_screen.dart';
import 'package:shining_india_survey/surveyor/survey_screen.dart';

class SurveyorHomeScreen extends StatefulWidget {
  const SurveyorHomeScreen({super.key});

  @override
  State<SurveyorHomeScreen> createState() => _SurveyorHomeScreenState();
}

class _SurveyorHomeScreenState extends State<SurveyorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                child: Text(
                  'Shining India Survey',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50)
                ),
                onPressed: (){
                  context.push(RouteNames.detailsScreen);
                },
                child: Text(
                  'Take a Survey'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
