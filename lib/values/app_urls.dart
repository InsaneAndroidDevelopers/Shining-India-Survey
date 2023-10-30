class AppUrls {
  static const String baseUrl = 'http://15.207.164.179';

  //admin
  static const String adminLogin = '/auth/admin';
  static const String adminLogout = '';
  static const String adminGetAllSurveys = '/survey/surveys';
  static const String adminGetAllTeams = '';
  static const String adminCreateTeam = '';
  static const String adminCreateSurveyor = '';

  //surveyor
  static const String surveyorLogin = '/auth/surveyor';
  static const String surveyorLogout = '';
  static const String surveyorRecent = '/survey/recent';
  static const String surveyorGetSurveyQuestions = '/survey';
  static const String surveyorSubmitSurvey = '/survey/submit';

}