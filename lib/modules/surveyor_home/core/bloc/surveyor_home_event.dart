part of 'surveyor_home_bloc.dart';

abstract class SurveyorHomeEvent extends Equatable {
  const SurveyorHomeEvent();
}

class GetRecentSurveys extends SurveyorHomeEvent {
  @override
  List<Object?> get props => [];
}

class SurveyorLogout extends SurveyorHomeEvent {
  @override
  List<Object?> get props => [];
}

class GetSurveyorInfo extends SurveyorHomeEvent {
  @override
  List<Object?> get props => [];
}