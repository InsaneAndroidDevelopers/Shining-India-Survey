import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_home/core/bloc/admin_home_bloc.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/bloc/filled_survey_bloc.dart';
import 'package:shining_india_survey/modules/login/core/bloc/login_bloc.dart';
import 'package:shining_india_survey/modules/splash/core/bloc/splash_bloc.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/bloc/surveyor_home_bloc.dart';
import 'package:shining_india_survey/routes/app_router.dart';
import 'package:shining_india_survey/modules/splash/ui/splash_screen.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_screen.dart';
import 'package:shining_india_survey/modules/surveyor_home/ui/surveyor_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyBloc(),
        ),
        BlocProvider(
          create: (context) => AdminHomeBloc(),
        ),
        BlocProvider(
          create: (context) => SurveyorHomeBloc(),
        ),
        BlocProvider(
          create: (context) => CreateUpdateSurveyorBloc(),
        ),
        BlocProvider(
          create: (context) => FilledSurveyBloc(),
        )
      ],
      child: MaterialApp.router(
        title: 'Shining India Survey',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true
        ),
        debugShowCheckedModeBanner: false,
        routeInformationParser: AppRouter.goRouter.routeInformationParser,
        routerDelegate: AppRouter.goRouter.routerDelegate,
        routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
      ),
    );
  }
}
