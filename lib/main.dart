import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shining_india_survey/helpers/hive_db_helper.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/bloc/create_update_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/admin_home/core/bloc/admin_home_bloc.dart';
import 'package:shining_india_survey/modules/admin_reassign_surveyor/core/bloc/unassigned_surveyor_bloc.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/bloc/filled_survey_bloc.dart';
import 'package:shining_india_survey/modules/login/core/bloc/login_bloc.dart';
import 'package:shining_india_survey/modules/splash/core/bloc/splash_bloc.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/bloc/analysis_bloc.dart';
import 'package:shining_india_survey/modules/surveyor_home/core/bloc/surveyor_home_bloc.dart';
import 'package:shining_india_survey/routes/app_router.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await HiveDbHelper.openBox();
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
        ),
        BlocProvider(
          create: (context) => AnalysisBloc(),
        ),
        BlocProvider(
          create: (context) => UnassignedSurveyorBloc(),
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
