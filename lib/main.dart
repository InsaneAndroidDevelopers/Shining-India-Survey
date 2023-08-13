import 'package:flutter/material.dart';
import 'package:shining_india_survey/splash_screen.dart';
import 'package:shining_india_survey/surveyor/survey_screen.dart';
import 'package:shining_india_survey/surveyor/surveyor_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shining India Survey',
      debugShowCheckedModeBanner: false,
      home: SurveyorHomeScreen()
    );
  }
}
