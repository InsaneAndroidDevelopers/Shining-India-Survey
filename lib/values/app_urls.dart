class AppUrls {
  static const String baseUrl = 'http://15.207.164.179';

  //admin
  static const String adminLogin = '/auth/admin';
  static const String adminLogout = '';
  static const String adminGetAllSurveys = '/survey/surveys';
  static const String adminGetAllTeams = '/team';
  static const String adminCreateTeam = '/team/create';
  static const String adminCreateSurveyor = '/surveyor/create';
  static const String adminAddSurveyorIntoTeam = '/team/add';
  static const String adminDeleteSurveyor = '';

  //surveyor
  static const String surveyorLogin = '/auth/surveyor';
  static const String surveyorLogout = '';
  static const String surveyorRecent = '/survey/recent';
  static const String surveyorGetSurveyQuestions = '/survey';
  static const String surveyorSubmitSurvey = '/survey/submit';

}