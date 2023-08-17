import 'package:flutter/material.dart';
import 'package:shining_india_survey/login_screen.dart';
import 'package:shining_india_survey/routes/app_router.dart';
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
    return MaterialApp.router(
      title: 'Shining India Survey',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouter.goRouter.routeInformationParser,
      routerDelegate: AppRouter.goRouter.routerDelegate,
      routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
    );
  }
}
