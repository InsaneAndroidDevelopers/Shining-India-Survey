class AppUrls {
  static const String baseUrl = 'http://43.204.33.102';

  //admin
  static const String adminLogin = '/auth/admin';
  static const String adminLogout = '/auth/logout';
  static const String adminGetAllSurveys = '/survey/surveys';
  static const String adminGetAllTeams = '/team';
  static const String adminCreateTeam = '/team/create';
  static const String adminCreateSurveyor = '/surveyor/create';
  static const String adminAddSurveyorIntoTeam = '/team/add';
  static const String adminDeleteSurveyor = '/team/removeFromTeam';
  static const String adminFilterSurveys = '/survey/filter';
  static const String adminAnalyseSurveys = '/survey/analyse';

  //surveyor
  static const String surveyorLogin = '/auth/surveyor';
  static const String surveyorLogout = '/auth/logout';
  static const String surveyorRecent = '/survey/recent';
  static const String surveyorGetSurveyQuestions = '/survey';
  static const String surveyorSubmitSurvey = '/survey/submit';

}