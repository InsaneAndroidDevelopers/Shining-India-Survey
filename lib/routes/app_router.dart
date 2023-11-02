import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/core/models/team_model.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/admin_create_update_surveyor_screen.dart';
import 'package:shining_india_survey/modules/admin_home/ui/admin_home_screen.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/admin_surveyors_screen.dart';
import 'package:shining_india_survey/modules/admin_create_update_surveyor/ui/admin_teams_screen.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/filled_surveys.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/survey_detail_screen.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/survey_reponses_screen.dart';
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
          final List<Members> surveyors = state.extra as List<Members>;
          return AdminSurveyorScreen(
            surveyors: surveyors,
            teamName: state.uri.queryParameters['teamName'] as String,
            teamId: state.uri.queryParameters['teamId'] as String
          );
        },
      ),
      GoRoute(
        name: RouteNames.adminCreateUpdateSurveyorScreen,
        path: RouteNames.adminCreateUpdateSurveyorScreen,
        builder: (context, state) {
          return AdminCreateUpdateSurveyorScreen(
            isUpdate: bool.parse(state.uri.queryParameters['isUpdate'] ?? 'false'),
            name: state.uri.queryParameters['name'] as String,
            surveyorId: state.uri.queryParameters['surveyorId'] as String,
            teamId: state.uri.queryParameters['teamId'] as String
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
      GoRoute(
        name: RouteNames.adminFilledSurveysScreen,
        path: RouteNames.adminFilledSurveysScreen,
        builder: (context, state) {
          return AdminFilledSurveys();
        },
      ),
      GoRoute(
        name: RouteNames.adminFilledSurveyDetailScreen,
        path: RouteNames.adminFilledSurveyDetailScreen,
        builder: (context, state) {
          final SurveyResponseModel surveyResponseModel = state.extra as SurveyResponseModel;
          return SurveyDetailScreen(surveyResponseModel: surveyResponseModel);
        },
      ),
      GoRoute(
        name: RouteNames.adminFilledSurveyResponses,
        path: RouteNames.adminFilledSurveyResponses,
        builder: (context, state) {
          final List<QuestionResponseModel> responses = state.extra as List<QuestionResponseModel>;
          return SurveyResponsesScreen(responses: responses);
        },
      ),
    ]
  );
}