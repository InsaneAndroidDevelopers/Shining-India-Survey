import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/admin_create_update_surveyor_screen.dart';
import 'package:shining_india_survey/modules/admin_home/ui/admin_home_screen.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/admin_surveyors_screen.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/admin_teams_screen.dart';
import 'package:shining_india_survey/modules/login/ui/admin_login_screen.dart';
import 'package:shining_india_survey/modules/login/ui/login_screen.dart';
import 'package:shining_india_survey/modules/login/ui/surveyor_login_screen.dart';
import 'package:shining_india_survey/modules/survey/ui/details_screen.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_result_screen.dart';
import 'package:shining_india_survey/modules/survey_analysis/ui/admin_survey_analysis_screen.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/modules/splash/ui/splash_screen.dart';
import 'package:shining_india_survey/modules/survey/ui/additional_details_screen.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_screen.dart';
import 'package:shining_india_survey/modules/surveyor_home/ui/surveyor_home_screen.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    routes: [
      GoRoute(
        name: RouteNames.splashScreen,
        path: RouteNames.splashScreen,
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        name: RouteNames.loginScreen,
        path: RouteNames.loginScreen,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        name: RouteNames.surveyorLoginScreen,
        path: RouteNames.surveyorLoginScreen,
        builder: (context, state) {
          return SurveyorLoginScreen();
        },
      ),
      GoRoute(
        name: RouteNames.surveyorHomeScreen,
        path: RouteNames.surveyorHomeScreen,
        builder: (context, state) {
          return SurveyorHomeScreen();
        },
      ),
      GoRoute(
        name: RouteNames.detailsScreen,
        path: RouteNames.detailsScreen,
        builder: (context, state) {
          return DetailsScreen();
        },
      ),
      GoRoute(
        name: RouteNames.surveyScreen,
        path: RouteNames.surveyScreen,
        builder: (context, state) {
          return SurveyScreen();
        },
      ),
      GoRoute(
        name: RouteNames.additionalDetailsScreen,
        path: RouteNames.additionalDetailsScreen,
        builder: (context, state) {
          return AdditionalDetailsScreen();
        },
      ),
      GoRoute(
        name: RouteNames.surveyResultScreen,
        path: RouteNames.surveyResultScreen,
        builder: (context, state) {
          return SurveyResultScreen();
        },
      ),
      GoRoute(
        name: RouteNames.adminLoginScreen,
        path: RouteNames.adminLoginScreen,
        builder: (context, state) {
          return AdminLoginScreen();
        },
      ),
      GoRoute(
        name: RouteNames.adminHomeScreen,
        path: RouteNames.adminHomeScreen,
        builder: (context, state) {
          return AdminHomeScreen();
        },
      ),
      GoRoute(
        name: RouteNames.adminTeamsScreen,
        path: RouteNames.adminTeamsScreen,
        builder: (context, state) {
          return AdminTeamsScreen();
        },
      ),
      GoRoute(
        name: RouteNames.adminSurveyorsScreen,
        path: RouteNames.adminSurveyorsScreen,
        builder: (context, state) {
          return AdminSurveyorScreen();
        },
      ),
      GoRoute(
        name: RouteNames.adminCreateUpdateSurveyorScreen,
        path: RouteNames.adminCreateUpdateSurveyorScreen,
        builder: (context, state) {
          return AdminCreateUpdateSurveyorScreen(
            isUpdate: bool.parse(state.uri.queryParameters['isUpdate'] ?? 'false'),
            name: state.uri.queryParameters['name'] as String,
          );
        },
      ),
      GoRoute(
        name: RouteNames.adminSurveyAnalysisScreen,
        path: RouteNames.adminSurveyAnalysisScreen,
        builder: (context, state) {
          return AdminSurveyAnalysisScreen();
        },
      ),
    ]
  );
}